//
//  ComicViewModel.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicViewModel {
    
    let comic: Comic
    let coverImage: UIImage?
    
    init(comic: Comic, coverImage: UIImage?) {
        self.comic = comic
        self.coverImage = coverImage
    }
    
    var nameTitle: String {
        if let name = comic.title {
            return name.components(separatedBy: "#")[0]
        }
        return ""
    }
    
    var issueNumberTitle: String {
        if let issue = comic.issueNumberString {
            return "Number: \(issue)"
        }
        return ""
    }
    
    var descriptionText: String {
        if let desc = comic.description {
            return desc
        }
        return "No description found"
    }
    
    var heroNamesText: String {
        if let heroNames = comic.characters, heroNames.count > 0 {
            var text = ""
            for hero in heroNames {
                text += hero
            }
        }
        
        return "No hero found in this comic"
        
    }
    
    
}