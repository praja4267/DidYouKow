//
//  RestManager.swift
//  KnowSomeThing
//
//  Created by Rajasekhar on 05/08/20.
//  Copyright © 2020 Rajasekhar. All rights reserved.
//

import Foundation
class RestManager {
    let baseURL = "https://dl.dropboxusercontent.com"
    static let shared = RestManager()
    let session = URLSession.shared
    
    func getRequest(endpoint: String, completion: @escaping ((Result<CountryModel, APIError>) -> Void)) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(Result.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(Result.failure(.otherError(error: error)))
            }
            guard let jsonData = String(decoding: data!, as: UTF8.self).data(using: .utf8) else {
                completion(Result.failure(.invalidResponse))
                return
            }
            do {
                let countryModel = try JSONDecoder().decode(CountryModel.self, from: jsonData)
                completion(Result.success(countryModel))
            }
            catch let error {
                completion(Result.failure(.otherError(error: error)))
            }
        }.resume()
    }
}

enum APIError: Error {
    case invalidURL
    case invalidResponse
    case otherError(error: Error)
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "The URL provided is not valid"
        case .invalidResponse:
            return "Received invalid response"
        case .otherError(let error):
            return error.localizedDescription
        }
    }
    
}
