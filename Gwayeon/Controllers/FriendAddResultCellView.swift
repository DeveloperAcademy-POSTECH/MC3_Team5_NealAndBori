//
//  FriendAddResultCellView.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/27.
//

import UIKit

class FriendAddResultCellView: UIView {

    private let fruitImage = UIImageView()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let codeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        label.textColor = UIColor.systemGray
        return label
    }()
    
    private let recommendCountLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.mainColor
        return label
    }()
    
    private let friendTextLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor.systemGray
        label.text = "개의 과일을 추천해요"
        return label
    }()
    
    func configure(data : User) {
        self.nameLabel.text = data.userName
        self.codeLabel.text = data.pinCode
        self.fruitImage.image = UIImage(named: "watermelon") // TODO: 서버에서 받아온 프로필로 변경
        guard let recommends = data.recommends, !recommends.isEmpty else {
            self.recommendCountLabel.text = "0"
            return
        }
        self.recommendCountLabel.text = String(recommends.count) // TODO: 서버에서 받아온 추천 과일 수로 변경
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        self.addSubviews(nameLabel, codeLabel, fruitImage, recommendCountLabel, friendTextLabel)
        
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24),
            nameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5)
        ]
        
        let codeLabelConstraints = [
            codeLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            codeLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5)
        ]
        
        let fruitImageConstraints = [
            fruitImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            fruitImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            fruitImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            fruitImage.widthAnchor.constraint(equalToConstant: 64),
            fruitImage.heightAnchor.constraint(equalToConstant: 64)
        ]
        
        let recommendCountLabelConstraints = [
            recommendCountLabel.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24),
            recommendCountLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2.5)
        ]
        
        let friendTextLabelConstraints = [
            friendTextLabel.leadingAnchor.constraint(equalTo: recommendCountLabel.trailingAnchor),
            friendTextLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2.5)
        ]
        
        [nameLabelConstraints, codeLabelConstraints, fruitImageConstraints, recommendCountLabelConstraints, friendTextLabelConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
