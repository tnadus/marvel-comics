//
//  MarvelComicsAPI.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import Foundation
import SwiftyJSON

typealias FetchComicsCallback = ([Comic]) -> Void
typealias FetchComicsErrorCallback = (Error) -> Void

protocol MarvelComicsAPIProtocol {
    func fetchComicData(onSuccess: FetchComicsCallback?,
                        onError: FetchComicsErrorCallback?)
}

class MarvelComicsAPI: MarvelComicsAPIProtocol {
    
    let API_BASE_URL = "https://gateway.marvel.com/v1/public/comics"
    let API_PUBLIC_KEY  = "3031e125033011e273d7d758f6441fcd"
    let API_PRIVATE_KEY = "184bb21ba2bea458403fd2d2fabf9e3854ad9ffd"
    let API_ORDER_BY = "onsaleDate"
    let API_LIMIT = "30"
    let API_OFFSET = "0"
    
    func fetchComicData(onSuccess: FetchComicsCallback?,
                        onError: FetchComicsErrorCallback?) {
    
        let timestamp = UUID().uuidString.replacingOccurrences(of: "-", with: "", options: String.CompareOptions.literal, range: nil)
        let md5String = String.md5(String(format:"%@%@%@", timestamp, API_PRIVATE_KEY, API_PUBLIC_KEY))
        let urlString = String(format:"%@?orderBy=%@&limit=%@&offset=%@&ts=%@&apikey=%@&hash=%@",API_BASE_URL, API_ORDER_BY, API_LIMIT, API_OFFSET, timestamp, API_PUBLIC_KEY, md5String)
        
        guard let url = URL(string: urlString) else {
            let err = NSError(domain: "invalid url", code: 999, userInfo: nil)
            onError?(err)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let err = error {
                print(err)
                onError?(err)
                return
            }
            
            if response == nil || (response as! HTTPURLResponse).statusCode != 200 {
                let err = NSError(domain: "Response is empty or status code is not 200", code: 400, userInfo: nil)
                onError?(err)
                return
            }
            
            guard let data = data  else {
                let err = NSError(domain: "response data is nil", code: 400, userInfo: nil)
                onError?(err)
                return
            }
            
            let jsonDataAll = JSON(data: data)
            let comicsJSON = jsonDataAll["data"]["results"].arrayValue
            
            var comics:[Comic] = []
            
            for comicJSON in comicsJSON {
                let comic = Comic(comicJSON)
                comics.append(comic)
            }
            onSuccess?(comics)
            
        }.resume()
    }
}

