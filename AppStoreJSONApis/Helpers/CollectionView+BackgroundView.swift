//
//  CollectionView+BackgroundView.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

extension UICollectionView {
    func setupEmptyState(with message: String){
        
        let enterSearchTermLabel: UILabel = {
            let label = UILabel()
            label.text = message
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
        
        self.backgroundView = enterSearchTermLabel
        
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
