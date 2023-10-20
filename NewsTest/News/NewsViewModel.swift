//
//  NewsViewModel.swift
//  NewsTest
//
//  Created by mac on 8.10.23.
//

import Foundation

@MainActor final class NewsViewModel: ObservableObject {
    
    @Published var isRequestFailed = false
    @Published var breeds: [Article] = []
    
    private var apiManager: NetworkServiceManagers
    
     init(apiManager: NetworkServiceManagers) {
        self.apiManager = apiManager
    }
    
    func load() async {
        await fetch()
    }
    
    func fetch() async  {
//        guard let apiManager = apiManager else {return}
        do {
            let endpoint = NewsEndpoint.getNews
            let response: News = try await apiManager.request(endpoint: endpoint)
            
            breeds += response.articles
            
        } catch {
            if error is URLError {
                isRequestFailed = true
                print("error")
                
                return
            }
        }
    }
}
