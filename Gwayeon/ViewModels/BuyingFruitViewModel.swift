//
//  BuyingFruitViewModel.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/31.
//

import Foundation

struct BuyingFruitViewModel {
    let date: Date
    let fruitName: String
    let fruitType: String
    let farmName: String
    var dateToString: String {
        return dateFormatter.string(from: date)
    }
}
