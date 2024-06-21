//
//  ApiBuilder.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 15.06.2024.
//

import Foundation
import Combine

struct ApiBuilder {
    
    static func fetchData<T: Decodable>(from url: URL) -> AnyPublisher<T, NetworkError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw NetworkError.requestFailed
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return NetworkError.decodingFailed
                } else {
                    return NetworkError.requestFailed
                }
            }
            .eraseToAnyPublisher()
    }
}
