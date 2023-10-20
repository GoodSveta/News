//
//  NetworkServiceManager.swift
//  NewsTest
//
//  Created by mac on 8.10.23.
//

import Foundation

protocol NetworkServiceManagers {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

final class NetworkServiceManager: NetworkServiceManagers {
    
    lazy var session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func request<T>(endpoint: Endpoint) async throws -> T where T : Decodable {
        
        let request = try endpoint.asURLRequest()
        
        let (data, response) = try await session.data(for: request)
        
        debugPrint("Called request: \(request)")
        
        let httpResponse = response as? HTTPURLResponse
        
        debugPrint("Finished request: \(response)")
        
        
        guard let status =  httpResponse?.statusCode, (200...299).contains(status) else {
            throw APIError.unaceptableStatusCode
        }
        
        let decoder = JSONDecoder()
        
        do {
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            throw APIError.decodingFailed(error: error)
        }
    }
}
