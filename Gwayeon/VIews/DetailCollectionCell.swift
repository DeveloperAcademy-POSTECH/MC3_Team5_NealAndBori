//
//  CollectionCell.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/20.
//

import UIKit

class DetailCollectionCell: UICollectionViewCell {
    
    // MARK: Properties
    var item: String? {
        didSet {
            self.label.text = item
        }
    }
    
    lazy var label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func configures() {
        backgroundColor = .systemGray6
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        let labelConstraints = [
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor)
        ]
        NSLayoutConstraint.activate(labelConstraints)
    }
}
