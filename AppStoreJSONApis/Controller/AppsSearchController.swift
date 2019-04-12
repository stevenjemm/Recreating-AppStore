//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 11/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {
    
    fileprivate let cellId = "CellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultsCell
        
        return cell
    }
    
    fileprivate func fetchITunesApps() {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                print("Failed to fetch apps: ", error!.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                searchResult.results.forEach({ print($0.trackName, $0.primaryGenreName) })
            } catch {
                print("Error decoding JSON: ", error.localizedDescription)
            }
        }.resume()
    }
    
    
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
}
