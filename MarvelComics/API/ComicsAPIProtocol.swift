//
//  ComicsAPIProtocol.swift
//  MarvelComics
//
//  Created by Murat Sudan on 08/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import Foundation

typealias FetchComicsCallback = ([Comic]) -> Void
typealias FetchComicsErrorCallback = (Error) -> Void

protocol ComicsAPIProtocol {
    func fetchComicData(onSuccess: FetchComicsCallback?,
                        onError: FetchComicsErrorCallback?)
}
