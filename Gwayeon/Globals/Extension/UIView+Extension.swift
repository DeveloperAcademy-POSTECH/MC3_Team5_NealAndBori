//
//  UIView+Extension.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//
import UIKit

extension UIView {
  func addSubviews(_ views: UIView...) {
    for view in views {
      view.translatesAutoresizingMaskIntoConstraints = false
      self.addSubview(view)
    }
  }
}
