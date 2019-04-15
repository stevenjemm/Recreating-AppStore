//
//  ReviewCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "Review Title", font: .boldSystemFont(ofSize: 16))
    
    let authorLabel = UILabel(text: "Author", font: .systemFont(ofSize: 16))
    
    let starsStackView: UIStackView = {
        
        var arrangedSubviews = [UIView]()
        (0..<5).forEach({ _ in
            let imageView = UIImageView(image: #imageLiteral(resourceName: "star"))
            imageView.constrainWidth(constant: 20)
            imageView.constrainHeight(constant: 20)
            arrangedSubviews.append(imageView)
        })
        arrangedSubviews.append(UIView())
        
        let stackView = UIStackView(arrangedSubviews: arrangedSubviews)
        return stackView
    }()
    
    let bodyLabel = UILabel(text: "Review body\nReview body\nReview body\n", font: .systemFont(ofSize: 16), numberOfLines: 5)
    
    var entry: Entry? {
        didSet {
            titleLabel.text = entry?.title.label
            authorLabel.text = entry?.author.name.label
            bodyLabel.text = entry?.content.label
            
            for (index, view) in self.starsStackView.arrangedSubviews.enumerated() {
                if let ratingInt = Int(entry?.rating.label ?? "0") {
                    view.alpha = index >= ratingInt ? 0 : 1
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.cornerRadius = 10
        clipsToBounds = true
        
        authorLabel.textColor = UIColor(white: 0.5, alpha: 1)
        authorLabel.textAlignment = .right
        let topStackView = UIStackView(arrangedSubviews: [titleLabel, authorLabel], customSpacing: 8)
        let stackView = VerticalStackView(arrangedSubviews: [topStackView, starsStackView, bodyLabel], spacing: 8)
        
        
        titleLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
        
        addSubview(stackView)
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 20, left: Constants.leftRightPadding, bottom: 0, right: Constants.leftRightPadding))
//        stackView.fillSuperview(padding: .init(top: 12, left: 12, bottom: 12, right: 12))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
