//
//  MovieSearchCollectionViewManager.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/16/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation
import UIKit

protocol MovieSearchCollectionViewManagerDelegate: class
{
    func movieSelected()
}

class MovieSearchCollectionViewManager: NSObject
{
    let inset: CGFloat = 5
    let minimumLineSpacing: CGFloat = 5
    let minimumInteritemSpacing: CGFloat = 5
    let cellsPerRow = 3

    weak var collectionView: UICollectionView?
    weak var delegate: MovieSearchCollectionViewManagerDelegate?

    func setup(collectionView: UICollectionView?)
    {
        collectionView?.register(MovieCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.keyboardDismissMode = .onDrag

        self.collectionView = collectionView
    }
}

extension MovieSearchCollectionViewManager: UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 50
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else { return UICollectionViewCell() }
        return cell
    }
}

extension MovieSearchCollectionViewManager: UICollectionViewDelegate
{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        print("selected index: \(indexPath)")
        delegate?.movieSelected()
    }
}

extension MovieSearchCollectionViewManager: UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat
    {
        return minimumLineSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat
    {
        return minimumInteritemSpacing
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        let marginsAndInsets = inset * 2 + collectionView.safeAreaInsets.left + collectionView.safeAreaInsets.right + minimumInteritemSpacing * CGFloat(cellsPerRow - 1)
        let itemWidth = (collectionView.bounds.size.width - marginsAndInsets) / CGFloat(cellsPerRow).rounded(.down)
        return CGSize(width: itemWidth, height: 200)
    }
}
