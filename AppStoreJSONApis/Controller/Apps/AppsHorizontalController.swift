//
//  AppsHorizontalController.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppsHorizontalController: HorizontalSnappingController {
    
    fileprivate let cellId = "horCell"
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 10
    
    var appGroup: AppGroup? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    var didSelectHandler: ((FeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.contentInset = .init(top: 0, left: Constants.leftRightPadding, bottom: 0, right: 0)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! AppRowCell
        
        let app = appGroup?.feed.results[indexPath.item]
        cell.nameLabel.text = app?.name
        cell.companyLabel.text = app?.artistName
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let app = appGroup?.feed.results[indexPath.item] {
            
            didSelectHandler?(app)
        }
        
    }
    
}

extension AppsHorizontalController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.height - (2 * topBottomPadding) - (2 * lineSpacing)) / 3
        
        return .init(width: view.frame.width - (Constants.leftRightPadding * 2), height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: topBottomPadding, left: 0, bottom: topBottomPadding, right: Constants.leftRightPadding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
}
