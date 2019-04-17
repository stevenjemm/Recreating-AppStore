//
//  TodayItem.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 17/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    let cellType: CellType
    
    enum CellType: String {
        case single
        case multiple
    }
}
