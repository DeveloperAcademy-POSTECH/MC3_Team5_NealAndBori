//
//  CollectionCell.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/20.
//

import UIKit

class ReviewCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "DetailCollectionViewCell"
    
    // MARK: Properties
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.preferredMaxLayoutWidth = self.bounds.width - 40
//        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDetailCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Configures
    func setDetailCollectionViewLayout() {
        backgroundColor = .systemGray6
        
        [dateLabel, contentLabel, authorLabel].forEach { component in
            self.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        let contentLabelConstraints = [
            contentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            contentLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ]
        
        let authorLabelConstraints = [
            authorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -24),
            authorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        ]
        
        [dateLabelConstraints, contentLabelConstraints, authorLabelConstraints].forEach { constraints in NSLayoutConstraint.activate(constraints)
        }
    }
}
