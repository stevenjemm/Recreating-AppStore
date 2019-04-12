//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 11/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController {
    
    fileprivate let cellId = "CellId"
    fileprivate var appResults = [_Result]()
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer?
    
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultsCell.self, forCellWithReuseIdentifier: cellId)
        
        setupSearchBar()
        
//        fetchITunesApps()
    }
    
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if appResults.isEmpty {
            collectionView.setupEmptyState(with: "Please enter search term above")
            return 0
        } else {
            collectionView.restore()
            return appResults.count
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultsCell
        
        cell.appResult = appResults[indexPath.item]
        
        return cell
    }
    
    fileprivate func fetchITunesApps() {
        
        Service.shared.fetchApps(searchTerm: "instagram") { (result) in
            switch result {
            case .failure(let error):
                print("Failed to fetch apps: ", error)
            case .success(let results):
                self.appResults = results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    fileprivate func setupSearchBar() {
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
}

extension AppsSearchController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}

extension AppsSearchController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            Service.shared.fetchApps(searchTerm: searchText) { (result) in
                switch result {
                case .success(let results):
                    self.appResults = results
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    print("Failed to fetch apps for \(searchText): ", error)
                }
            }
        })
        
    }
}
