//
//  Parsing.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

enum ParsingError: Error
{
    case failed
    case empty
}

typealias JSON = [String: Any?]

extension Decodable
{
    static func array<ModelType: Decodable>(from data: Data?) throws -> [ModelType]
    {
        guard let data = data else { throw ParsingError.failed }
        guard !data.isEmpty else { throw ParsingError.empty }

        do
        {
            let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
            //an ugly hacky tweak to handle annoying json formatting from the API
            var cleanedUpJson: Any?
            if let searchArray = json as? JSON
            {
                cleanedUpJson = searchArray["Search"] ?? nil
            }

            let jsonObjects: [ModelType] = try Self.array(from: cleanedUpJson ?? json)

            return jsonObjects
        }
        catch
        {
            throw error
        }
    }

    static func array<ModelType: Decodable>(from json: Any?) throws -> [ModelType]
    {
        guard let json = json else { throw ParsingError.failed }

        var jsonObjects = [ModelType]()

        if let jsonArray = json as? [JSON]
        {
            jsonObjects = jsonArray.compactMap { (json) -> ModelType? in
                try? JSONDecoder().decode(ModelType.self, from: try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted))
            }
        }
        else
        {
            guard let json = json as? JSON else { throw ParsingError.failed }

            if json.isEmpty
            {
                return jsonObjects
            }

            do
            {
                let jsonObject = try JSONDecoder().decode(ModelType.self, from: try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted))
                jsonObjects.append(jsonObject)
            }
            catch
            {
                throw error
            }
        }
        return jsonObjects
    }
}
