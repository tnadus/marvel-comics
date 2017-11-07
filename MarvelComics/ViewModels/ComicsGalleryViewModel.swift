//
//  ComicsGalleryViewModel.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicsGalleryViewModel {
    
    let marvelComicsAPI: MarvelComicsAPIProtocol
    let title = "Comics Gallery"
    let cache = NSCache<AnyObject, AnyObject>()
    let dateFormatterInput = DateFormatter()
    let dateFormatterOutput = DateFormatter()
    
    //var datas = Variable<[FlickrData]>([])
    var comics: Dynamic<[Comic]> = Dynamic(value:[])
    
    init() {
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        dateFormatterOutput.dateFormat = "yyyy-MM-dd"
        self.marvelComicsAPI = MarvelComicsAPI()
        
        marvelComicsAPI.fetchComicData(onSuccess: { (comics) in
            self.comics.value = comics
        }) { (err) in
            print("Failed to fetch data")
        }
    }
    
    func cellSize(width: CGFloat, height: CGFloat) -> CGSize {
        let size = CGSize(width: width, height: height)
        return size
    }
    
    func cellTitle(indexPath: IndexPath) -> String {
        if let titleFull = comics.value[indexPath.row].title {
            return titleFull.components(separatedBy: "#")[0]
        }
        return ""
    }
    
    func cellIssueNumberTitle(indexPath: IndexPath) -> String {
        if let number = comics.value[indexPath.row].issueNumberString {
            return "Issue number: \(number)"
        }
        return ""
    }
    
    func formattedDateString(_ dateString: String) -> String {
        let dateObj = dateFormatterInput.date(from: dateString)
        if let date = dateObj {
            let formattedString = dateFormatterOutput.string(from:date)
            return formattedString
        }
        return ""
    }
    
    func loadImage(urlString: String, completion: @escaping (UIImage?) -> Void) {
        
        if let img = cache.object(forKey: urlString as AnyObject) as? UIImage {
            completion(img)
            return
        }
        
        ImageLoader.load(urlString: urlString) { data in
            
            if let dataImg = data {
                let img = UIImage(data: dataImg)
                self.cache.setObject(img!, forKey: urlString as AnyObject)
                completion(img)
            }
        }
    }
    
}
