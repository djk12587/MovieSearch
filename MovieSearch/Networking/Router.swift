//
//  Router.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

enum RouterError: Error
{
    case invalidBaseUrl, invalidQueryParams
}

enum NetworkResponse: Error
{
    case success
    case authenticationError
    case badRequest
    case failed
    case noData
    case unableToDecode
    case cancelled
}

protocol NetworkRouter
{
    associatedtype ExpectedResponseModelType: Decodable

    var baseURL: String { get }
    var apiKey: String { get }
    var parameters: [String: Any]? { get }

    func asURLRequest() throws -> URLRequest
}

extension NetworkRouter
{
    var baseURL: String
    {
        return "http://www.omdbapi.com/"
    }

    var apiKey: String
    {
        return "1d81a8b8"
    }

    func asURLRequest() throws -> URLRequest
    {
        var queryItems = [URLQueryItem(name: "apikey", value: apiKey), URLQueryItem(name: "type", value: "movie")]

        parameters?.forEach { (param) in
            queryItems.append(URLQueryItem(name: param.key, value: param.value as? String))
        }

        guard var urlComps = URLComponents(string: baseURL) else { throw RouterError.invalidBaseUrl }
        urlComps.queryItems = queryItems
        guard let url = urlComps.url else { throw RouterError.invalidQueryParams }

        var mutableRequest = URLRequest(url: url)
        mutableRequest.httpMethod = "GET"

        return mutableRequest
    }
}

extension NetworkRouter
{
    @discardableResult
    func request(completion: @escaping (Outcome<[ExpectedResponseModelType]>) -> Void) -> URLSessionTask?
    {
        guard let urlRequest = try? asURLRequest() else { return nil }
        let session = URLSession.shared

        let task = session.dataTask(with: urlRequest) { (data, urlResponse, error) in

            guard (error as NSError?)?.code != NSURLErrorCancelled, data != nil else
            {
                DispatchQueue.main.async { completion(.failure(NetworkResponse.cancelled)) }
                return
            }

            guard let responseData = data else
            {
                DispatchQueue.main.async { completion(.failure(NetworkResponse.noData)) }
                return
            }
            guard let parsedModels: [ExpectedResponseModelType] = try? ExpectedResponseModelType.array(from: responseData) else
            {
                DispatchQueue.main.async { completion(.failure(NetworkResponse.unableToDecode )) }
                return
            }

            DispatchQueue.main.async { completion(.success(parsedModels)) }
        }

        task.resume()

        return task
    }
}
