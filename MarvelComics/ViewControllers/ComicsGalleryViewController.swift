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
        cell.issueNumberLabel.text = viewModel.cellIssueNumberTitle(indexPath: indexPath)
        
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

//MARK: UIViewCollectionDelegate
extension ComicsGalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ComicGalleryCell
        let comic = viewModel.comics.value[indexPath.row]
        
        let comicVc: ComicViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ComicViewController") as! ComicViewController
        comicVc.viewModel = ComicViewModel(comic: comic, coverImage: cell.coverImgView.image)
        self.navigationController?.pushViewController(comicVc, animated: true)
    }
}

extension ComicsGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.cellSize(width: self.view.frame.width, height: 90.0)
    }
}

