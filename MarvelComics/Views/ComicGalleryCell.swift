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
        l.textColor = .black
        l.font = UIFont.boldSystemFont(ofSize: 14.0)
        return l
    }()
    
    let issueNumberLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .black
        l.font = UIFont.systemFont(ofSize: 12.0)
        return l
    }()
    
    let bottomLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.8, alpha: 1.0)
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var isHighlighted: Bool {
        didSet {
            if(isHighlighted == true){
                self.backgroundColor = .lightGray
            } else{
                self.backgroundColor = .white
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupViews()
    }
    
    func setupViews() {
        
        self.addSubview(coverImgView)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-12-[pv(==60)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["pv" : coverImgView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-5-[pv]-5-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["pv" : coverImgView]))
        
        self.addSubview(titleLabel)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-85-[tl]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["tl" : titleLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[tl(==30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["tl" : titleLabel]))
        
        self.addSubview(issueNumberLabel)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-85-[inl]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["inl" : issueNumberLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[inl(==30)]", options: NSLayoutFormatOptions(), metrics: nil, views: ["inl" : issueNumberLabel]))
        
//        self.addSubview(bottomLine)
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bl]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))
//        
//        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bl(==1)]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))
        
    }
    
}
