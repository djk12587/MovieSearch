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
}

extension HomeScreenViewController: UISearchResultsUpdating
{
    func updateSearchResults(for searchController: UISearchController)
    {
        searchController.searchResultsController?.view.isHidden = false
    }
}

extension HomeScreenViewController: MovieSearchCollectionViewManagerDelegate
{
    func movieSelected()
    {
        performSegue(withIdentifier: MovieDetailViewController.segueId, sender: nil)
    }
}
