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
        label.text = "19.07.21"
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.text = "세상 존맛탱. 이 세상 복숭아가 아니다. 과즙 팡팡이에요. 사장님도 정말 친절하시구요. 저만 먹기 너무 아까워서 모두에게 알려요."
        label.preferredMaxLayoutWidth = self.bounds.width - 40
//        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        label.text = "from. 쏘니"
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
