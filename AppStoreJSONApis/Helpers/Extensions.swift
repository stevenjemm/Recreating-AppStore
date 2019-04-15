//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 12/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String, font: UIFont, numberOfLines: Int = 1) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
        self.numberOfLines = numberOfLines
    }
}

extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

extension UIStackView {
    convenience init(arrangedSubviews: [UIView], customSpacing: CGFloat = 0) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.spacing = customSpacing
    }
}

//extension UIView {
//    
//    func drawInnerShadow() {
//        let layer = CAGradientLayer()
//        layer.startPoint    = .init(x: 0.5, y: 0.0)
//        layer.endPoint      = .init(x: 0.5, y: 1.0)
//        layer.colors        = [UIColor(white: 0.1, alpha: 1.0).cgColor, UIColor(white: 0.1, alpha: 0.5).cgColor, UIColor.clear.cgColor]
//        layer.locations     = [0.05, 0.2, 1.0 ]
//        layer.frame         = .init(x: 0, y: 0, width: self.frame.width, height: 60)
//        self.layer.insertSublayer(layer, at: 0)
//        
//    }
//}
