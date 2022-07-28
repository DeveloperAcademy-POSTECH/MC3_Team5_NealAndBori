//
//  FruitCollectionViewCell.swift
//  Gwayeon
//
//  Created by COBY_PRO on 2022/07/20.
//

import UIKit

final class FruitCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "FruitCollectionViewCell"
    
    // MARK: - property
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .mainRed
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewLayout()
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
    
    private func setCollectionViewLayout() {
        contentView.addSubview(nameLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabelConstraints = [
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ]
        NSLayoutConstraint.activate(nameLabelConstraints)
    }
    
    private func setConfigureUI() {
        clipsToBounds = true
        contentView.layer.cornerRadius = 22.5
        contentView.backgroundColor = .mainRed.withAlphaComponent(0.15)
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                contentView.backgroundColor = .mainRed
                self.nameLabel.textColor = .white
            } else {
                contentView.backgroundColor = .mainRed.withAlphaComponent(0.15)
                self.nameLabel.textColor = .mainRed
            }
        }
    }
}
