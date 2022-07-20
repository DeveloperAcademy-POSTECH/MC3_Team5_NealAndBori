//
//  FarmCollectionCell.swift
//  Gwayeon
//
//  Created by COBY_PRO on 2022/07/19.
//

import UIKit

final class FarmCollectionViewCell: UICollectionViewCell {
    
    static let cellId = "FarmCollectionViewCell"
    
    // MARK: - property
    
    private let peoplePickLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .grey001
        label.text = "에이든 외 3명 Pick!"
        return label
    }()
    
    private let fruitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .mainRed
        label.text = "청송사과"
        return label
    }()
    
    private let farmLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "자연 농원"
        return label
    }()
    
    private let fruitInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = "신선하고 과즙이 팡팡이에요"
        return label
    }()
    
    private var fruitImageView: UIImageView = { imageView in
        imageView.image = UIImage(named: "peach")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }(UIImageView(frame: .zero))
    
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
        [peoplePickLabel, fruitLabel, farmLabel, fruitInfoLabel, fruitImageView].forEach { component in
            contentView.addSubview(component)
        }
        
        peoplePickLabel.translatesAutoresizingMaskIntoConstraints = false
        let peoplePickLabelConstraints = [
            peoplePickLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            peoplePickLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        fruitLabel.translatesAutoresizingMaskIntoConstraints = false
        let fruitLabelConstraints = [
            fruitLabel.topAnchor.constraint(equalTo: peoplePickLabel.bottomAnchor, constant: 16),
            fruitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
                
        farmLabel.translatesAutoresizingMaskIntoConstraints = false
        let farmLabelConstraints = [
            farmLabel.topAnchor.constraint(equalTo: fruitLabel.bottomAnchor, constant: 6),
            farmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        fruitInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        let fruitInfoLabelConstraints = [
            fruitInfoLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor, constant: 24),
            fruitInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        fruitImageView.translatesAutoresizingMaskIntoConstraints = false
        let fruitImageViewConstraints = [
            fruitImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            fruitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            fruitImageView.widthAnchor.constraint(equalToConstant: 80)
        ]
        
        [peoplePickLabelConstraints, fruitLabelConstraints, farmLabelConstraints, fruitInfoLabelConstraints, fruitImageViewConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
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
