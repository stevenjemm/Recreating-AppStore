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
        
        let term = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlString = "https://itunes.apple.com/search?term=\(term!)&entity=software"
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
    
    func fetchGames(completion: @escaping (Result<AppGroup, Error>) -> ()) {
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json")!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error getting games: ", error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
//            print(String(data: data!, encoding: .utf8))
            
            guard let data = data else { return }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data)
//                print(appGroup.feed.results)
//                appGroup.feed.results.forEach({ print($0.name) })
                completion(.success(appGroup))
                
            } catch {
                print("Error decoding json: ", error)
                completion(.failure(error))
            }
        }.resume()
    }
}
