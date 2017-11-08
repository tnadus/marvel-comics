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
    let defaultColor = UIColor(red: 64.0/255.0, green: 64.0/255.0, blue: 64.0/255.0, alpha: 1.0)
    var shouldTintBackgroundWhenSelected = true // You can change default value
    var specialHighlightedArea: UIView?
    
    //MARK: Subviews
    
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
        l.textColor = .white
        l.font = UIFont.boldSystemFont(ofSize: 14.0)
        return l
    }()
    
    let issueNumberLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .lightGray
        l.font = UIFont.systemFont(ofSize: 12.0)
        return l
    }()
    
    let bottomLine: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        return v
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = defaultColor
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
        
        self.addSubview(bottomLine)
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bl]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[bl(==1)]-0-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["bl" : bottomLine]))

    }
}

//MARK: - Cell highlight

extension ComicGalleryCell {
    
    override var isHighlighted: Bool { // make lightgray background show immediately(使灰背景立即出现)
        willSet {
            onSelected(newValue)
        }
    }
    
    override var isSelected: Bool { // keep lightGray background until unselected (保留灰背景)
        willSet {
            onSelected(newValue)
        }
    }
    
    func onSelected(_ newValue: Bool) {
        guard selectedBackgroundView == nil else { return }
        if shouldTintBackgroundWhenSelected {
            contentView.backgroundColor = newValue ? .gray : defaultColor
        }
        if let sa = specialHighlightedArea {
            sa.backgroundColor = newValue ? UIColor.black.withAlphaComponent(0.4) : defaultColor
        }
    }
}






