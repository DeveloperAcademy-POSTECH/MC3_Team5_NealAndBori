//
//  FriendListViewCell.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//
// TODO: Color+Extension 적용

import UIKit

class FriendListViewCell: UITableViewCell {
    
    static let cellId = "FriendCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let fruitImage = UIImageView()
    
    private let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let friendNumberLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(red: 246/256, green: 104/256, blue: 94/256, alpha: 1.00)
        return label
    }()
    
    private let friendTextLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 151/256, green: 151/256, blue: 151/256, alpha: 1.00)
        label.text = "명의 과연이 있어요"
        return label
    }()
    
    private let friendView : UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }()
    
//    func configure(data : User) {
//
//        self.nameLabel.text = data.userName
//        self.fruitImage.image = UIImage(named: data.userImageName)
//        self.friendNumberLabel.text = "100"
//    }
    func configure(userName : String, userImageName : String, friendsNumber : Int) {
     
        self.nameLabel.text = userName
        self.fruitImage.image = UIImage(named: userImageName)
        self.friendNumberLabel.text = String(friendsNumber)
    }
    
    private func setLayout() {
        
        [friendNumberLabel, friendTextLabel].forEach { component in
            self.friendView.addArrangedSubview(component)
        }
        
        [nameLabel, fruitImage, friendView].forEach { component in
            self.addSubview(component)
        }
        
        [nameLabel, fruitImage, friendNumberLabel, friendTextLabel,friendView].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let nameLabelConstraints = [
            nameLabel.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24),
            nameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5)
        ]
        
        let fruitImageConstraints = [
            fruitImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            fruitImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 18),
            fruitImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18),
            fruitImage.widthAnchor.constraint(equalToConstant: 64),
            fruitImage.heightAnchor.constraint(equalToConstant: 64)
        ]
                
        let friendViewConstrains = [
            friendView.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24),
            friendView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2.5)
        ]
        
        [nameLabelConstraints, fruitImageConstraints, friendViewConstrains].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
        
    }

}
