//
//  Comics.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit
import SwiftyJSON

struct Comic {
    
    let id: String?
    let title: String?
    var issueNumberString: String?
    var coverImageURL: String?
    let description: String?
    var characters: [String]?
}

extension Comic {
    
    init(_ jsonComic: JSON) {
        self.id = String(jsonComic["id"].intValue)
        self.title = jsonComic["title"].string
        self.issueNumberString = String(jsonComic["issueNumber"].intValue)
      
        if let imgPath = jsonComic["thumbnail"]["path"].string, let imgExt = jsonComic["thumbnail"]["extension"].string {
            self.coverImageURL = imgPath + "." + imgExt
        }
        self.description = jsonComic["description"].string
        
        if let heros = jsonComic["characters"]["items"].array {
            self.characters = []
            for hero in heros {
                if let heroName = hero["name"].string {
                    characters?.append(heroName)
                }
            }
        }
    }
}
