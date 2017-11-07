//
//  ComicViewController.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicViewController: UIViewController {
    
    @IBOutlet weak var coverImgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var charactersTextView: UITextView!
    
    var viewModel:ComicViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        coverImgView.image = viewModel?.coverImage
        nameLabel.text = viewModel?.nameTitle
        issueLabel.text = viewModel?.issueNumberTitle
        descriptionTextView.text = viewModel?.descriptionText
        charactersTextView.text = viewModel?.heroNamesText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
