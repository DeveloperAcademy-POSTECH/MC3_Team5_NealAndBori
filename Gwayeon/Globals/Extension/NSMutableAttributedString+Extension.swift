//
//  NSMutableAttributedString+Extension.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/20.
//

import UIKit

extension NSMutableAttributedString {
    
    func setColor(color: UIColor?, forText stringValue: String) {
        guard let color = color else {
            return
        }
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
