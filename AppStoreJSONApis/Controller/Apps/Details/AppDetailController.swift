//
//  AppDetailController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 14/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppDetailController: BaseListController {
    
    // MARK: - Properties
    private let detailCellId = "detailCellId"
    var app: _Result?
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJSONData(urlString: urlString) { (searchResult: Result<SearchResult, Error>) in
                switch searchResult {
                case .success(let results):
                    
                    let app = results.results.first
                    self.app = app
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                    
                case .failure(let error):
                    print("Error returning results: ", error)

                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        navigationItem.largeTitleDisplayMode = .never
        
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: detailCellId)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailCellId, for: indexPath) as! AppDetailCell
        cell.app = self.app
        
        return cell
    }
}

extension AppDetailController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let size: CGSize = .init(width: view.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let dummyCell = AppDetailCell(frame: .init(origin: .zero, size: size))
        dummyCell.app = self.app
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(size)
        
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}