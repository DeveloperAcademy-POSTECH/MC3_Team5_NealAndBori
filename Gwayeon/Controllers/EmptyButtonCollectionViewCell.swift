//
//  EmptyButtonCollectionViewCell.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/21.
//

import UIKit

class EmptyButtonCollectionViewCell: UICollectionViewCell {
    static let identifier = "EmptyButtonCollectionViewCell"
    
    lazy private var plusButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 36, weight: .bold, scale: .large)
    
        let plusButtonImage = UIImage(systemName: "plus.app.fill", withConfiguration: config)
        button.setImage(plusButtonImage, for: .normal)
        button.tintColor = .gray
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setContentViewLayout()
        setButtonLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("EmptyCollectionViewCell Error")
    }
    
    private func setContentViewLayout() {
        contentView.backgroundColor = UIColor(red: 0.922, green: 0.922, blue: 0.922, alpha: 1)
        contentView.layer.cornerRadius = 22.5
    }
    
    private func setButtonLayout() {
        
        contentView.addSubview(plusButton)
        plusButton.translatesAutoresizingMaskIntoConstraints = false
        
        let plusButtonConstraints = [
            plusButton.centerXAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerXAnchor),
            plusButton.centerYAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(plusButtonConstraints)
    }
    
}
