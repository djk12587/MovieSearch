//
//  MovieCollectionViewCell.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/16/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell, ReusableNib
{
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!

    var imageTask: URLSessionTask?

    func setUp(using movieThumbNail: MovieThumbNail)
    {
        movieTitleLabel.text = movieThumbNail.title
        imageTask?.cancel()
        imageTask = moviePosterImageView.imageFromURL(url: movieThumbNail.posterUrl)
    }
}
