//
//  ViewController.swift
//  MarvelComics
//
//  Created by Murat Sudan on 07/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import UIKit

class ComicsGalleryViewController: UICollectionViewController {
    
    let viewModel = ComicsGalleryViewModel(comicsAPI: MarvelComicsAPI())
    var spinner: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        bindViews()
    }
    
    func setupViews() {
        self.title = viewModel.title
        setupBarButton()
    }
    
    func setupBarButton() {
        self.spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        spinner?.backgroundColor = .darkGray
        spinner?.isOpaque = true
        spinner?.layer.cornerRadius = (spinner?.frame.width)!/2.0
        spinner?.layer.borderColor = UIColor.black.cgColor
        spinner?.layer.borderWidth = 1.0
        spinner?.hidesWhenStopped = true
        spinner?.startAnimating()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: spinner!)
    }
    
    func bindViews() {
        viewModel.comics.bind { [unowned self] _ in
            self.collectionView?.reloadData()
            self.spinner?.stopAnimating()
        }
    }
    
    //MARK: Memory management
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: - UIViewCollectionDataSource

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

//MARK: - UIViewCollectionDelegate

extension ComicsGalleryViewController {
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! ComicGalleryCell
        let comic = viewModel.comics.value[indexPath.row]
        
        let comicVc: ComicViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ComicViewController") as! ComicViewController
        comicVc.viewModel = ComicViewModel(comic: comic, coverImage: cell.coverImgView.image)
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            self.navigationController?.pushViewController(comicVc, animated: true)
        } else {
            let navigationController = UINavigationController(rootViewController: comicVc)
            navigationController.modalPresentationStyle = .formSheet
            present(navigationController, animated: true, completion: nil)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - UIViewCollectionFlowLayoutDelegate

extension ComicsGalleryViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if (UIDevice.current.userInterfaceIdiom == .phone) {
            return viewModel.cellSize(width:self.view.frame.width, height: 90.0)
        }
        
        return viewModel.cellSize(width: (self.view.frame.width/3.0 - 20), height: 90.0)
    }
}

