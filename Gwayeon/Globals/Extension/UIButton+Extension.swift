//
//  UIButton+Extension.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/21.
//

import UIKit

extension UIButton {
    func setButtonBlur() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([.foregroundColor : UIColor(red: 0.851, green: 0.851, blue: 0.851, alpha: 1)], range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
    
    func setButtonHighlight() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([.underlineStyle: 1.0, .foregroundColor : UIColor.black], range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}
