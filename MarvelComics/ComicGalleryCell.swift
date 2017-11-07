//
//  ComicGalleryCell.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicGalleryCell: UICollectionViewCell {
    
    var urlString = ""
    
    let coverImgView: UIImageView = {
        let iv = UIImageView(frame: .zero)
        iv.backgroundColor = .black
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .orange
        l.textColor = .black
        l.text = "Comic title goes here"
        return l
    }()
    
    let artistLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.backgroundColor = .orange
        l.textColor = .black
        l.text = "artist name goes here"
        return l
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        
        self.addSubview(coverImgView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[pv(==60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["pv" : coverImgView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[pv(==80)]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["pv" : coverImgView]))
        
        self.addSubview(titleLabel)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-85-[tl]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["tl" : titleLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[tl(==30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["tl" : titleLabel]))
        
        self.addSubview(artistLabel)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-85-[al]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["al" : artistLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[al(==30)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["al" : artistLabel]))
        
    }
    
}