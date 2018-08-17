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
    override func viewDidLoad()
    {
        super.viewDidLoad()

        navigationItem.title = "Detail"
        view.backgroundColor = .red
    }
}
