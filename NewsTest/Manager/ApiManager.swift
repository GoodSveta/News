//
//  ApiManager.swift
//  NewsTest
//
//  Created by mac on 8.10.23.
//

import Foundation

enum APIError: Error {
    case unaceptableStatusCode
    case decodingFailed(error: Error)
    case invalidUrlComponents
}




