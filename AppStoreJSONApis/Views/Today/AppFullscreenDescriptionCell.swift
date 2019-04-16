//
//  AppFullscreenDescriptionCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppFullscreenDescriptionCell: UICollectionViewCell {
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        let attributedText = NSMutableAttributedString(string: "Great Games", attributes: [.foregroundColor: UIColor.black])
        
        attributedText.append(NSAttributedString(string: " are all about the details, from subtle visual effects to imaginative art styles. In these titles, you're sure to find something to marvel at, whether you're into fantasy worlds or neon-soaked dartboards.", attributes: [.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: " \n\n\nHerois adventure", attributes: [.foregroundColor : UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor : UIColor.gray]))
        
        attributedText.append(NSAttributedString(string: " \n\n\nHerois adventure", attributes: [.foregroundColor : UIColor.black]))
        
        attributedText.append(NSAttributedString(string: "\nBattle in dungeons. Collect treasure. Solve puzzles. Sail to new lands. Oceanhorn lets you do it all in a beautifully detailed world.", attributes: [.foregroundColor : UIColor.gray]))
        
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.attributedText = attributedText
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = #colorLiteral(red: 0.8971505165, green: 0.8977522254, blue: 0.9179338813, alpha: 1)
        addSubview(descriptionLabel)
        descriptionLabel.fillSuperview(padding: .init(top: 20, left: Constants.leftRightPadding, bottom: 20, right: Constants.leftRightPadding))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
