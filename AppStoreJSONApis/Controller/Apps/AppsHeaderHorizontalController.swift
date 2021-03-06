//
//  AppsHeaderHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppsHeaderHorizontalController: HorizontalSnappingController {
    
    fileprivate let cellId = "id"
    var socialApps = [SocialApp]() {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var socialAppHandler: ((SocialApp) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppsHeaderCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = .init(top: 0, left: Constants.leftRightPadding, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return socialApps.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppsHeaderCell
        
        let app = socialApps[indexPath.item]
        cell.app = app
//        cell.companyLabel.text = app.name
//        cell.titleLabel.text = app.tagline
//        cell.imageView.sd_setImage(with: URL(string: app.imageUrl), placeholderImage: nil, options: [.progressiveLoad])
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        socialAppHandler?(socialApps[indexPath.item])
//        let appDetailController = AppDetailController(appId: socialApps[indexPath.item].id)
//        navigationController?.pushViewController(appDetailController, animated: true)
    }
}

extension AppsHeaderHorizontalController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - (Constants.leftRightPadding * 2), height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 0, left: 0, bottom: 0, right: Constants.leftRightPadding)
    }
}
