//
//  AppsController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppsPageController: BaseListController {
    
    // MARK: - Properties
    fileprivate let cellId = "id"
    fileprivate let headerId = "headerId"
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.hidesWhenStopped = true
        aiv.startAnimating()
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        view.addSubview(activityIndicatorView)
        activityIndicatorView.fillSuperview()
        
        fetchData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalController.socialApps = self.socialApps
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsGroupCell
        
        let appGroup = groups[indexPath.item]
        
        cell.titleLabel.text = appGroup.feed.title
        cell.horizontalController.appGroup = appGroup     // Property Observer on appGroup to reload CollectionView
        return cell
    }
    
    // MARK: - Helper Methods
    fileprivate func fetchData() {
        
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (result) in
            
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                
                group1 = appGroup
                
//                self.groups.append(appGroup)
//
//                DispatchQueue.main.async {
//                    self.collectionView.reloadData()
//                }
                
            case .failure(let error):
                print("Failed to fetch games: ", error)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (result) in
            
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                
                group2 = appGroup
                
            case .failure(let error):
                print("Failed to fetch topGrossing apps: ", error)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchFreeApps { (result) in
            
            dispatchGroup.leave()
            switch result {
            case .success(let appGroup):
                
                group3 = appGroup
                
            case .failure(let error):
                print("Failed to fetch free apps: ", error)
            }
        }
        
        dispatchGroup.enter()
        Service.shared.fetchSocialApps { (result) in
            dispatchGroup.leave()
            switch result {
            case .success(let apps):
                
                self.socialApps = apps
//                group3 = objects
                
            case .failure(let error):
                print("Failed to fetch social apps: ", error)
            }
        }
        
        // Completion Block for DispatchGroup
        dispatchGroup.notify(queue: .main) {
            print("Completed your dispatch group tasks")
            
            self.activityIndicatorView.stopAnimating()
            
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            
            self.collectionView.reloadData()
        }
    }
    
}


extension AppsPageController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
}
