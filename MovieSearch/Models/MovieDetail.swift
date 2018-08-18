//
//  MovieDetail.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

struct MovieDetail
{
    let imdbId: String
    let plot: String
    let year: String
    let title: String
    let posterUrl: String
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
        case posterUrl = "Poster"
        case rating = "Metascore"
    }

    init(from decoder: Decoder) throws
    {
        let movieContainer = try decoder.container(keyedBy: MovieDetailCodingKeys.self)

        imdbId = try movieContainer.decode(String.self, forKey: .imdbId)
        plot = try movieContainer.decode(String.self, forKey: .plot)
        year = try movieContainer.decode(String.self, forKey: .year)
        title = try movieContainer.decode(String.self, forKey: .title)
        posterUrl = try movieContainer.decode(String.self, forKey: .posterUrl)
        rating = try movieContainer.decode(String.self, forKey: .rating)
    }
}
