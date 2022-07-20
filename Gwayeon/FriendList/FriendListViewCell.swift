//
//  FriendListViewCell.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

class FriendListViewCell: UITableViewCell {
    
    static let cellId = "FriendCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let fruitImage = UIImageView()
    
    let nameLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    let friendNumberLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(red: 246/256, green: 104/256, blue: 94/256, alpha: 1.00)
        return label
    }()
    
    let friendTextLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .medium)
        label.textColor = UIColor(red: 151/256, green: 151/256, blue: 151/256, alpha: 1.00)
        label.text = "명의 과연이 있어요"
        return label
    }()
    
    let friendView : UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 0
        
        return stackView
    }()
    
    func render() {
        
        self.friendView.addArrangedSubview(friendNumberLabel)
        self.friendView.addArrangedSubview(friendTextLabel)
        
        self.addSubview(nameLabel)
        self.addSubview(fruitImage)
        self.addSubview(friendView)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitImage.translatesAutoresizingMaskIntoConstraints = false
        friendNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        friendTextLabel.translatesAutoresizingMaskIntoConstraints = false
        friendView.translatesAutoresizingMaskIntoConstraints = false
        
        fruitImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24).isActive = true
        fruitImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 18).isActive = true
        fruitImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -18).isActive = true
        fruitImage.widthAnchor.constraint(equalToConstant: 64).isActive = true
        fruitImage.heightAnchor.constraint(equalToConstant: 64).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -2.5).isActive = true

        friendView.leadingAnchor.constraint(equalTo: self.fruitImage.trailingAnchor, constant: 24).isActive = true
        friendView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 2.5).isActive = true
        
    }

}
