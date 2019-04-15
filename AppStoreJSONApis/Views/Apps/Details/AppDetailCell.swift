//
//  AppDetailsCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 14/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    let appIconImageView = UIImageView(cornerRadius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 18), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 24))
    let versionLabel = UILabel(text: "0.0.0", font: .systemFont(ofSize: 16))
    let releaseNotesLabel = UILabel(text: "Release Notes", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    var app: _Result? {
        didSet {
            self.appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""))
            self.nameLabel.text = app?.trackName
            self.releaseNotesLabel.text = app?.releaseNotes
            self.priceButton.setTitle(app?.formattedPrice, for: .normal)
            self.versionLabel.text = app?.version
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        appIconImageView.backgroundColor = .white
        appIconImageView.constrainWidth(constant: 100)
        appIconImageView.constrainHeight(constant: 100)
        
        versionLabel.textColor = UIColor(white: 0.5, alpha: 1)
        
        priceButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.constrainWidth(constant: 80)
        priceButton.layer.cornerRadius = 32/2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        
        let buttonStackView = UIStackView(arrangedSubviews: [priceButton, UIView()])
        let textStackView = VerticalStackView(arrangedSubviews: [nameLabel, buttonStackView], spacing: 12)
        let horizontalStackView = UIStackView(arrangedSubviews: [appIconImageView, textStackView], customSpacing: 16)
        
        let stackView = VerticalStackView(arrangedSubviews: [horizontalStackView, whatsNewLabel, versionLabel, releaseNotesLabel], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: Constants.leftRightPadding, bottom: 20, right: Constants.leftRightPadding))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
