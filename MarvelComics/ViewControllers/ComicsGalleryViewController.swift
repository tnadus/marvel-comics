//
//  ViewController.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicsGalleryViewController: UICollectionViewController {
    
    let viewModel = ComicsGalleryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = viewModel.title
        
        viewModel.comics.bind { [unowned self] _ in
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: UIViewCollectionDataSource

extension ComicsGalleryViewController {

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.comics.value.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCellId", for: indexPath) as! ComicGalleryCell
        
        cell.titleLabel.text = viewModel.cellTitle(indexPath: indexPath)
        
        if let dateString = viewModel.comics.value[indexPath.row].releaseDateString {
            cell.releaseDateLabel.text = viewModel.formattedDateString(dateString)
        } else {
            cell.releaseDateLabel.text = ""
        }
        
        if let urlStr = viewModel.comics.value[indexPath.row].coverImageURL {
            cell.urlString = urlStr
            viewModel.loadImage(urlString: urlStr, completion: { img in
                if let image = img {
                    if cell.urlString == urlStr {
                        cell.coverImgView.image = image
                    }
                }
            })
        }
        
        return cell
    }
}

extension ComicsGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize(width: self.view.frame.width, height: 90.0)
    }
}

