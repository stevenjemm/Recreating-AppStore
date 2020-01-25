//
//  AppsHeaderCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    
    let titleLabel = UILabel(text: "Keeping up with friends is faster than ever", font: .systemFont(ofSize: 24))
    
    let imageView = UIImageView(cornerRadius: 8)
    
    var app: SocialApp? {
        didSet {
            companyLabel.text = app?.name
            titleLabel.text = app?.tagline
            imageView.sd_setImage(with: URL(string: app?.imageUrl ?? ""), placeholderImage: nil, options: [.progressiveLoad])
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel.numberOfLines = 0
        companyLabel.textColor = .blue
        imageView.image = #imageLiteral(resourceName: "holiday")
        
        let stackView = VerticalStackView(arrangedSubviews: [companyLabel, titleLabel, imageView], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
