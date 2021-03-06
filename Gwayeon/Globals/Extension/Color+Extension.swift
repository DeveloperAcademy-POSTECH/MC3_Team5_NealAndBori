//
//  Color+Exntension.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

extension UIColor {
    static let pointColor = UIColor(ciColor: .red)
    static let tabBarColor = UIColor(named: "TabBarColor")
    static let mainColor = UIColor(named: "mainColor")
    static let peachColor = UIColor(named: "peachColor")
    
    static var mainRed: UIColor {
        return UIColor(hex: "#F6685E")
    }
    
    static var red001: UIColor {
        return UIColor(hex: "#FF5252")
    }
    
    static var grey001: UIColor {
        return UIColor(hex: "#878787")
    }
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()

        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }

        assert(hexFormatted.count == 6, "Invalid hex code used.")
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)

        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0, alpha: alpha)
    }
}
