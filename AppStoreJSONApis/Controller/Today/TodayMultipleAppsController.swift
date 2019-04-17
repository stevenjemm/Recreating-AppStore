//
//  TodayMultipleAppsController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 17/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class TodayMultipleAppsController: BaseListController {
    fileprivate let lineSpacing: CGFloat = 16
    private let multipleAppCellId = "multipleAppCellId"
    var results = [FeedResult]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: multipleAppCellId)
        collectionView.isScrollEnabled = false
        
        Service.shared.fetchTopGrossing { (result: Result<AppGroup, Error>) in
            switch result {
            case .success(let appGroup):
                self.results = appGroup.feed.results
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching data: ", error.localizedDescription)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: multipleAppCellId, for: indexPath) as! MultipleAppCell
        cell.app = self.results[indexPath.item]
        return cell
    }
}

extension TodayMultipleAppsController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height: CGFloat = (view.frame.height - (3 * lineSpacing)) / 4
        
        return .init(width: self.view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
