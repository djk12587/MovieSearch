//
//  MovieThumbNail.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

protocol MoviePosterUrl
{
    var posterUrlString: String { get }
}

extension MoviePosterUrl
{
    var posterUrl: URL?
    {
        return URL(string: posterUrlString)
    }
}

struct MovieThumbNail: MoviePosterUrl
{
    let imdbId: String
    let year: String
    let title: String
    let posterUrlString: String
}

extension MovieThumbNail: Decodable
{
    enum MovieThumbNailCodingKeys: String, CodingKey
    {
        case imdbId = "imdbID"
        case year = "Year"
        case title = "Title"
        case posterUrlString = "Poster"
    }

    init(from decoder: Decoder) throws
    {
        let movieThumbNailContainer = try decoder.container(keyedBy: MovieThumbNailCodingKeys.self)

        imdbId = try movieThumbNailContainer.decode(String.self, forKey: .imdbId)
        year = try movieThumbNailContainer.decode(String.self, forKey: .year)
        title = try movieThumbNailContainer.decode(String.self, forKey: .title)
        posterUrlString = try movieThumbNailContainer.decode(String.self, forKey: .posterUrlString)
    }
}
