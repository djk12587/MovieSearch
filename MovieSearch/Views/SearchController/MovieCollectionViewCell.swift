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

    func setUp(using movieThumbNail: MovieThumbNail)
    {
        movieTitleLabel.text = movieThumbNail.title
        moviePosterImageView.imageFromURL(url: movieThumbNail.posterUrl)
    }
}
