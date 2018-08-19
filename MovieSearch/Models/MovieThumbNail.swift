//
//  MovieThumbNail.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

struct MovieThumbNail
{
    let imdbId: String
    let year: String
    let title: String
    let posterUrl: String
}

extension MovieThumbNail: Decodable
{
    enum MovieThumbNailCodingKeys: String, CodingKey
    {
        case imdbId = "imdbID"
        case year = "Year"
        case title = "Title"
        case posterUrl = "Poster"
    }

    init(from decoder: Decoder) throws
    {
        let movieThumbNailContainer = try decoder.container(keyedBy: MovieThumbNailCodingKeys.self)

        imdbId = try movieThumbNailContainer.decode(String.self, forKey: .imdbId)
        year = try movieThumbNailContainer.decode(String.self, forKey: .year)
        title = try movieThumbNailContainer.decode(String.self, forKey: .title)
        posterUrl = try movieThumbNailContainer.decode(String.self, forKey: .posterUrl)
    }
}
