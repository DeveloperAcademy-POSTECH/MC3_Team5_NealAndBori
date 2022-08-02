//
//  DateFormatter.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/08/02.
//

import Foundation

let dateFormatter:DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd" // 2022
    formatter.locale = Locale(identifier: "ko_kr")
    return formatter
}()
