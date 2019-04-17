//
//  MultipleAppCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 17/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
            nameLabel.text = app.name
            companyLabel.text = app.artistName
        }
    }
    
    let imageView = UIImageView(cornerRadius: 8)
    
    let nameLabel = UILabel(text: "App Name", font: .systemFont(ofSize: 16))
    
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
    let getButton = UIButton(title: "Get".uppercased())
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .white
//        imageView.constrainWidth(constant: 56)
//        imageView.constrainHeight(constant: 64)
        let imageContainer = UIView()
        imageContainer.addSubview(imageView)
        imageView.fillSuperview()
        imageContainer.constrainWidth(constant: 60)
        imageContainer.constrainHeight(constant: 60)
        
        companyLabel.textColor = UIColor(white: 0.75, alpha: 1)
        getButton.backgroundColor = #colorLiteral(red: 0.9486771226, green: 0.9527952075, blue: 0.9556145072, alpha: 1)
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.layer.cornerRadius = 32 / 2
        
        let stackView = UIStackView(arrangedSubviews: [imageContainer, VerticalStackView(arrangedSubviews: [nameLabel, companyLabel], spacing: 4), getButton])
        stackView.spacing = 16
        stackView.alignment = .center
        addSubview(stackView)
        stackView.fillSuperview()
        
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLabel.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -8, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
