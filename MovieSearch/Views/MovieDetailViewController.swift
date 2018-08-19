//
//  MovieDetailViewController.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/16/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController, SegueIdentifier
{
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var moviePosterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var moviePlotLabel: UILabel!

    var imdbId: String = ""

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Detail"

        screenElements(shouldShow: false)

        MovieApi.GetMovieDetail(imdbID: imdbId).request { [weak self] (outcome) in
            guard let strongSelf = self else { return }
            switch outcome
            {
            case .success(let moviesDetail):
                if let movieDetail = moviesDetail.first
                {
                    strongSelf.setUpScreenElements(with: movieDetail)
                }
                else
                {
                    strongSelf.showErrorAlert()
                }
            case .failure:
                strongSelf.showErrorAlert()
            }
        }
    }

    private func showErrorAlert()
    {
        let alertController = UIAlertController(title: "Error", message: "There was a problem loading the movie information.", preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "okay", style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(okayAction)
        present(alertController, animated: true)
    }

    private func setUpScreenElements(with movieDetail: MovieDetail)
    {
        loadingIndicator.stopAnimating()
        screenElements(shouldShow: true)
        movieTitleLabel.text = movieDetail.title
        movieRatingLabel.text = "Metacritic Score: " + movieDetail.rating
        moviePlotLabel.text = movieDetail.plot
        moviePosterImageView.imageFromURL(url: movieDetail.posterUrl)
    }

    private func screenElements(shouldShow: Bool)
    {
        moviePosterImageView.isHidden = !shouldShow
        movieTitleLabel.isHidden = !shouldShow
        movieRatingLabel.isHidden = !shouldShow
        moviePlotLabel.isHidden = !shouldShow
    }
}
