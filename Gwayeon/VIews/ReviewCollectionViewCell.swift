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
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        label.text = "22.07.21"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "신선해요! 짱맛 복숭아 짱짱짱."
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        label.text = "쏘니"
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
            dateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        let contentLabelConstraints = [
//            contentLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            contentLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
//            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        ]
        
        let authorLabelConstraints = [
            authorLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 6),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        [dateLabelConstraints, contentLabelConstraints, authorLabelConstraints].forEach { constraints in NSLayoutConstraint.activate(constraints)
        }
    }
}
