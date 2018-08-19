//
//  HomeScreenViewController.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/16/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import UIKit

class HomeScreenViewController: UIViewController
{
    let searchController = UISearchController(searchResultsController: MovieSearchViewController(collectionViewLayout: UICollectionViewFlowLayout()))
    var movieSearchTask: URLSessionTask?

    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Movie Searcher"

        searchController.searchBar.placeholder = "Search Movie Titles"
        searchController.searchResultsUpdater = self
        (searchController.searchResultsController as? MovieSearchViewController)?.collectionViewManager.delegate = self
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        (segue.destination as? MovieDetailViewController)?.imdbId = (sender as? MovieThumbNail)?.imdbId ?? ""
    }
}

extension HomeScreenViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        guard let movieSearchText = searchController.searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), !movieSearchText.isEmpty else { return }

        movieSearchTask?.cancel()
        movieSearchTask = MovieApi.SearchMovies(titleSearch: movieSearchText).request(completion: { (outcome) in
            switch outcome
            {
            case .success(let movieThumbNails):
                (searchController.searchResultsController as? MovieSearchViewController)?.collectionViewManager.thumbNails = movieThumbNails
            case .failure(let error):
                guard let networkResponseError = error as? NetworkResponse, networkResponseError != .cancelled else { return }
                (searchController.searchResultsController as? MovieSearchViewController)?.collectionViewManager.thumbNails = []
            }
        })
    }
}

extension HomeScreenViewController: MovieSearchCollectionViewManagerDelegate
{
    func selected(movieThumbNail: MovieThumbNail)
    {
        performSegue(withIdentifier: MovieDetailViewController.segueId, sender: movieThumbNail)
    }
}
