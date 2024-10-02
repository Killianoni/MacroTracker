//
//  OpenFoodFactsAPI.swift
//  MacroTracker
//
//  Created by KILLIAN ADONAI on 17/09/2024.
//

import Combine
import Foundation

final class OpenFoodFactsAPI {
    private let devUrl = "https://world.openfoodfacts.net"
    private let prodUrl = "https://world.openfoodfacts.org"

    enum APIError: Error {
        case invalidURL
        case requestFailed
        case decodingError
    }

    func fetchProduct(barcode: String, cc: String, lc: String, fields: [String]) -> AnyPublisher<ProductVO, Error> {

        guard var urlComponents = URLComponents(string: "\(devUrl)/api/v3/product/\(barcode)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        urlComponents.queryItems = [
            URLQueryItem(name: "cc", value: cc),
            URLQueryItem(name: "lc", value: lc),
            URLQueryItem(name: "fields", value: fields.joined(separator: ","))
        ]

        guard let url = urlComponents.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: ProductVO.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}


