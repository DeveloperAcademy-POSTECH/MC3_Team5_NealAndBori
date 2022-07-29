//
//  Fruit.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/29.
//

import FirebaseFirestoreSwift

struct Fruit: Codable, Identifiable {
    @DocumentID var id: String?
    let fruitCategory, fruitName, farmName, farmTelNumber: String
    let recommends: [String]?
}
