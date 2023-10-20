//
//  Endpoint.swift
//  NewsTest
//
//  Created by mac on 8.10.23.
//

import Foundation

enum APIs: String {
    case baseAPIUrl =  "https://newsapi.org/v2/top-headlines?country=us&apiKey=601f0ceda1ed4fbbb12446adff6b96f1"
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
}

protocol Endpoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var urlParameters: [String: String] { get }
    
    func asURLRequest() throws -> URLRequest
}
extension Endpoint {
    var method: HTTPMethod {
        .get
    }
    
    var headers: [String: String] {
        [:]
    }
    
    var urlParameters: [String: String] {
        [:]
    }
    
    func asURLRequest() throws -> URLRequest {
        
        let url = URL(string: APIs.baseAPIUrl.rawValue)!
        
        guard let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            throw APIError.invalidUrlComponents
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidUrlComponents
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        
        return request
    }
}

enum NewsEndpoint: Endpoint {
    
    case getNews
    
    var path: String {
        switch self {
        case .getNews:
            return ""
        }
    }
    
    var urlParameters: [String : String] {
        switch self {
            
        case .getNews:
            return [:]
            
        }
    }
}
