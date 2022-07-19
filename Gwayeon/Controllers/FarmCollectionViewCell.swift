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
    
    let peoplePickLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .grey001
        label.text = "에이든 외 3명 Pick!"
        return label
    }()
    
    let fruitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .mainRed
        label.text = "청송사과"
        return label
    }()
    
    let farmLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.text = "자연 농원"
        return label
    }()
    
    let fruitInfoLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .black
        label.text = "신선하고 과즙이 팡팡이에요"
        return label
    }()
    
    private var fruitImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = UIImage(named: "peach")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configUI()
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
    
    func render() {
        contentView.addSubview(peoplePickLabel)
        contentView.addSubview(fruitLabel)
        contentView.addSubview(farmLabel)
        contentView.addSubview(fruitInfoLabel)
        contentView.addSubview(fruitImageView)
        
        peoplePickLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitLabel.translatesAutoresizingMaskIntoConstraints = false
        farmLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitImageView.translatesAutoresizingMaskIntoConstraints = false
        
        peoplePickLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17).isActive = true
        peoplePickLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        
        fruitLabel.topAnchor.constraint(equalTo: peoplePickLabel.bottomAnchor, constant: 16).isActive = true
        fruitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        
        farmLabel.topAnchor.constraint(equalTo: fruitLabel.bottomAnchor, constant: 6).isActive = true
        farmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        
        fruitInfoLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor, constant: 24).isActive = true
        fruitInfoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17).isActive = true
        
        fruitImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        fruitImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        fruitImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
//        fruitImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func configUI() {
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
