//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 11/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()   // Singleton
    
    func fetchApps(searchTerm: String, completion: @escaping (Result<[_Result], Error>) -> ()) {
        print("Fetching iTunes Apps from Service Layer")
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Failed to fetch apps: ", error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(.success(searchResult.results))
            } catch {
                print("Error decoding JSON: ", error.localizedDescription)
                completion(.failure(error))
            }
            }.resume()

    }
}
