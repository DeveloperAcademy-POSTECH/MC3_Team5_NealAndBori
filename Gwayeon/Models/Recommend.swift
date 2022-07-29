//
//  Recommend.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/28.
//

import FirebaseFirestoreSwift

struct Recommend: Codable, Identifiable {
    @DocumentID var id: String?
    let comment, userId, fruitId: String
}