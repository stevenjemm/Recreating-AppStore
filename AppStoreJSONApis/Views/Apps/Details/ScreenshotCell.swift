//
//  ScreenshotCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 14/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class ScreenshotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
