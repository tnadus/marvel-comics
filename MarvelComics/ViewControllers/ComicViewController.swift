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
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    //MARK: Subviews management
    func setupViews() {
        self.title = viewModel?.title
        coverImgView.image = viewModel?.coverImage
        nameLabel.text = viewModel?.nameTitle
        issueLabel.text = viewModel?.issueNumberTitle
        descriptionTextView.text = viewModel?.descriptionText
        charactersTextView.text = viewModel?.heroNamesText
        if (UIDevice.current.userInterfaceIdiom == .pad) {
            setupBarButtonItem();
        }
    }
    
    func setupBarButtonItem() {
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: viewModel?.barButtonItemTitle, style: UIBarButtonItemStyle.plain, target: self, action: #selector(onBarButtonItemTapped))
    }
    
    //MARK: Actions
    @objc func onBarButtonItemTapped(sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    
    //MARK: Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
