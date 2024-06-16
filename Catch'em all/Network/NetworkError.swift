//
//  NetworkError.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 16.06.2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case requestFailed
    case decodingFailed
}
