//
//  User.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import Foundation

struct User: Codable {
    
    var pinCode: String
    var username: String
    var friends: [String]
    var recommends: [String]
    
    enum CodingKeys: CodingKey {
        case pinCode
        case username
        case friends
        case recommends
    }
}
