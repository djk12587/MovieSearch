//
//  MovieSearchViewController.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/16/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import UIKit

class MovieSearchViewController: UICollectionViewController
{
    var collectionViewManager = MovieSearchCollectionViewManager()

    override func viewDidLoad()
    {
        super.viewDidLoad()

        collectionViewManager.setup(collectionView: collectionView)
        collectionView?.backgroundColor = .white
    }
}

