//
//  Recommend.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/28.
//

import Foundation
import FirebaseFirestoreSwift

struct Recommend: Codable, Identifiable {
    @DocumentID var id: String?
    let userId, fruitId, userName, comment: String
//    let comment, userId, fruitId, userName: String
}
