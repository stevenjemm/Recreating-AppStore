//
//  TodayMultipleAppCell.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 17/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class TodayMultipleAppCell: BaseTodayCell {
    
    override var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
        }
    }
    
    let categoryLabel = UILabel(text: "LIFE HACK", font: .boldSystemFont(ofSize: 16))
    let titleLabel = UILabel(text: "Utilizing your Time", font: .systemFont(ofSize: 24, weight: .semibold), numberOfLines: 0)
    
    let multipleAppsController = TodayMultipleAppsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        backgroundColor = .white
        categoryLabel.textColor = UIColor(white: 0.4, alpha: 1)
        
        let stackView = VerticalStackView(arrangedSubviews: [
            categoryLabel,
            titleLabel,
            multipleAppsController.view
            ], spacing: 12)
        
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 24, left: 24, bottom: 24, right: 24))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
