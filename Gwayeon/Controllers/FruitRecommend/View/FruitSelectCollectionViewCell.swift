//
//  FruitSelectCollectionViewCell.swift
//  Gwayeon
//
//  Created by 이윤영 on 2022/07/27.
//

import UIKit

class FruitSelectCollectionViewCell: UICollectionViewCell {
    static let identifier = "FruitSelectCollectionViewCell"

    private lazy var fruitImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        addSubviews(fruitImage, label)

        let fruitImageConstraint = [
            fruitImage.topAnchor.constraint(equalTo: topAnchor),
            fruitImage.widthAnchor.constraint(equalTo: widthAnchor),
            fruitImage.heightAnchor.constraint(equalTo: widthAnchor),
            fruitImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        let labelConstraint = [
            label.topAnchor.constraint(equalTo: fruitImage.bottomAnchor, constant: 8),
            label.centerXAnchor.constraint(equalTo: centerXAnchor)
        ]
        [fruitImageConstraint, labelConstraint].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }

    }
    
    func configure(text: String, image: String) {
        label.text = text
        fruitImage.image = UIImage(named: image)
    }
    
}
