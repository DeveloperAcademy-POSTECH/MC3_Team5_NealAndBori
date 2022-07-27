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
    
    private let friendView : UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 0
        return stackView
    }()
    
    func configure(data : FriendResultData) {
        self.nameLabel.text = data.name
        self.codeLabel.text = data.code
        self.fruitImage.image = UIImage(named: data.fruit)
        self.recommendCountLabel.text = String(data.recommendsCount)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [recommendCountLabel, friendTextLabel].forEach { component in
            self.friendView.addArrangedSubview(component)
        }
        
        [nameLabel, codeLabel,fruitImage, friendView].forEach { component in
            self.addSubview(component)
        }
        
        [nameLabel, codeLabel, fruitImage, recommendCountLabel, friendTextLabel,friendView].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
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
                
        let friendViewConstrains = [
            friendView.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24),
            friendView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2.5)
        ]
        
        [nameLabelConstraints, codeLabelConstraints, fruitImageConstraints, friendViewConstrains].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
