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
    
    func fetchApps(searchTerm: String, completion: @escaping (Result<SearchResult, Error>) -> ()) {
        print("Fetching iTunes Apps from Service Layer")
        
        let term = searchTerm.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let urlString = "https://itunes.apple.com/search?term=\(term!)&entity=software"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
//
//        let url = URL(string: urlString)!
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard error == nil else {
//                print("Failed to fetch apps: ", error!.localizedDescription)
//                completion(.failure(error!))
//                return
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
//                completion(.success(searchResult.results))
//            } catch {
//                print("Error decoding JSON: ", error.localizedDescription)
//                completion(.failure(error))
//            }
//            }.resume()

    }
    
    //        https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json
    //        https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json
    //        https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json
    
    func fetchTopGrossing(completion: @escaping (Result<AppGroup, Error>) -> ()) {
        
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
        
    }
    
    func fetchGames(completion: @escaping (Result<AppGroup, Error>) -> ()) {

        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
    }
    
    func fetchFreeApps(completion: @escaping (Result<AppGroup, Error>) -> ()) {
        
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json", completion: completion)
    }
    
    fileprivate func fetchAppGroup(urlString: String, completion: @escaping (Result<AppGroup, Error>) -> ()) {
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ((Result<[SocialApp], Error>) -> ())) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    // MARK: - Generic Function
    func fetchGenericJSONData<T: Decodable>(urlString: String, completion: @escaping (Result<T, Error>) -> ()) {

        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Error getting data: ", error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(.success(objects))
                
            } catch {
                print("Error decoding json: ", error)
                completion(.failure(error))
            }
            }.resume()
    }
    
}
