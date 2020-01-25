//
//  SocialApp.swift
//  AppStoreJSONApis
//
//  Created by Steven Jemmott on 13/04/2019.
//  Copyright © 2019 Steven Jemmott. All rights reserved.
//

import Foundation

struct SocialApp: Decodable, Hashable {
    let id, name, imageUrl, tagline: String
}
