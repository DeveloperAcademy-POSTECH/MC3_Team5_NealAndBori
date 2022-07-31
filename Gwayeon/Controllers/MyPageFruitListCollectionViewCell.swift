//
//  BuyingListCollectionViewCell.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/26.
//

import UIKit

class MyPageFruitListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BuyingListCollectionViewCell"
    // MARK: - property
    weak var parent: UIViewController?
    private let purchaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .grey001
        label.text = "2022.07.01"
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
    
    lazy private var recommendToFriendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.pencil"), for: .normal)
        button.setTitle("과연에게 추천하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        button.tintColor = .mainColor
        button.setTitleColor(UIColor.mainColor, for: .normal)
        button.addTarget(self, action: #selector(recommendToFriendButtonClicked(_:)), for: .touchUpInside)
        return button
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
        [purchaseDateLabel, fruitLabel, farmLabel, fruitInfoLabel,recommendToFriendButton, fruitImageView].forEach { component in
            contentView.addSubview(component)
        }
        
        purchaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        let peoplePickLabelConstraints = [
            purchaseDateLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17),
            purchaseDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        fruitLabel.translatesAutoresizingMaskIntoConstraints = false
        let fruitLabelConstraints = [
            fruitLabel.topAnchor.constraint(equalTo: purchaseDateLabel.bottomAnchor, constant: 16),
            fruitLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
                
        farmLabel.translatesAutoresizingMaskIntoConstraints = false
        let farmLabelConstraints = [
            farmLabel.topAnchor.constraint(equalTo: fruitLabel.bottomAnchor, constant: 6),
            farmLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
        ]
        
        recommendToFriendButton.translatesAutoresizingMaskIntoConstraints = false
        let recommendToGwayeonButtonConstraints = [
            recommendToFriendButton.topAnchor.constraint(equalTo: farmLabel.bottomAnchor, constant: 24),
            recommendToFriendButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17)
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
        
        [peoplePickLabelConstraints, fruitLabelConstraints, farmLabelConstraints, recommendToGwayeonButtonConstraints, fruitInfoLabelConstraints, fruitImageViewConstraints].forEach { constraints in
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
    
    @objc private func recommendToFriendButtonClicked(_ sender: Any) {
        let recommendToFriendViewController = RecommendToFriendViewController()
        parent?.navigationController?.pushViewController(recommendToFriendViewController, animated: true)
    }
    
    func setParentViewController(viewController: UIViewController) {
        self.parent = viewController
    }
    
    func setButtonOrLabelHidden(status: SegmentStatus) {
        
        switch status {
        case .myRecommendFruitList:
            fruitInfoLabel.isHidden = false
            recommendToFriendButton.isHidden = true
        case .buyingList:
            fruitInfoLabel.isHidden = true
            recommendToFriendButton.isHidden = false
        }
    }
}
