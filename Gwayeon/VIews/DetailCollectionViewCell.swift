//
//  CollectionCell.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/20.
//

import UIKit

class DetailCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "DetailCollectionCell"
    
    // MARK: Properties
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .systemGray
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDetailCollectionViewLayout()
        setConfigureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        super.preferredLayoutAttributesFitting(layoutAttributes)
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        var frame = layoutAttributes.frame
        
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
    
    // MARK: Configures
    func setDetailCollectionViewLayout() {
        backgroundColor = .systemGray6
        
        [dateLabel, contentLabel, authorLabel].forEach { component in
            self.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let dateLabelConstraints = [
            dateLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 24),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        let contentLabelConstraints = [
            contentLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        let authorLabelConstraints = [
            authorLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 6),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        [dateLabelConstraints, contentLabelConstraints, authorLabelConstraints].forEach { constraints in NSLayoutConstraint.activate(constraints)
        }
    }
    
    private func setConfigureUI() {
        clipsToBounds = true
        backgroundColor = .white
        layer.masksToBounds = false
        layer.cornerRadius = 20
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.12
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 20
    }
}
