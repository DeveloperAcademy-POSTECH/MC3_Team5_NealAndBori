//
//  RecommendFruitViewModel.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/08/01.
//

import Foundation

struct RecommendFruitViewModel {
    let date: Date
    let fruitName: String
    let fruitType: String
    let farmName: String
    let fruitComment: String
    var dateToString: String {
        return dateFormatter.string(from: date)
    }
}
