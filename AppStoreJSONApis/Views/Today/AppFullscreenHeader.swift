//
//  AppFullscreenHeader.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 15/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

class AppFullscreenHeader: UITableViewCell {
//
//    var imageView: UIImageView = {
//        let iv = UIImageView(image: #imageLiteral(resourceName: "garden"))
//        return iv
//    }()
    
    let todayCell = TodayCell()
    
    let closeButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .white
        addSubview(todayCell)
        todayCell.fillSuperview()
        
        addSubview(closeButton)
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        closeButton.anchor(top: topAnchor, leading: nil, bottom: nil, trailing: trailingAnchor, padding: .init(top: statusBarHeight + 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
