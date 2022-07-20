//
//  NSMutableAttributedString+Extension.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/20.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    func setColor(color: UIColor, forText stringValue: String) {
        let range: NSRange = self.mutableString.range(of: stringValue, options: .caseInsensitive)
        self.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
    }
}
