//
//  AppRowCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 20))
    
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let getButton = UIButton(title: "Get".uppercased())
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        
        companyLabel.textColor = UIColor(white: 0.75, alpha: 1)
        getButton.backgroundColor = #colorLiteral(red: 0.9555082917, green: 0.9493837953, blue: 0.9556146264, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [imageView, VerticalStackView(arrangedSubviews: [nameLabel,
                                                                                                       companyLabel], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
