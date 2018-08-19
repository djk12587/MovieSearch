//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

struct MovieDetail: MoviePosterUrl
{
    let imdbId: String
    let plot: String
    let year: String
    let title: String
    let posterUrlString: String
    let rating: String
}

extension MovieDetail: Decodable
{
    enum MovieDetailCodingKeys: String, CodingKey
    {
        case imdbId = "imdbID"
        case plot = "Plot"
        case year = "Year"
        case title = "Title"
        case posterUrlString = "Poster"
        case rating = "Metascore"
    }

    init(from decoder: Decoder) throws
    {
        let movieContainer = try decoder.container(keyedBy: MovieDetailCodingKeys.self)

        imdbId = try movieContainer.decode(String.self, forKey: .imdbId)
        plot = try movieContainer.decode(String.self, forKey: .plot)
        year = try movieContainer.decode(String.self, forKey: .year)
        title = try movieContainer.decode(String.self, forKey: .title)
        posterUrlString = try movieContainer.decode(String.self, forKey: .posterUrlString)
        rating = try movieContainer.decode(String.self, forKey: .rating)
    }
}
