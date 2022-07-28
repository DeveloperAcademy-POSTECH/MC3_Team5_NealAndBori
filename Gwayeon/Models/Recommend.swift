//
//  Recommend.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/28.
//

import Foundation

struct Recommend: Codable {
    
    var uid: String
    var fruitID: String
    var nickname: String
    var comment: String
    
    enum Codingkeys: CodingKey {
        case uid
        case fruitID
        case nickname
        case comment
    }
}
