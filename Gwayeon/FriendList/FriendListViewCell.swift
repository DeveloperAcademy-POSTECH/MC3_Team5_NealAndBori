//
//  FriendListViewCell.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

class FriendListViewCell: UITableViewCell {
    
    static let cellId = "ProfileCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let nameLabel = UILabel()
    let fruitImage = UIImageView()
    let friendLabel = UILabel()
    
    func render() {
//        contentView.addSubview([nameLabel, fruitImage, friendLabel])
        self.addSubview(nameLabel)
        self.addSubview(fruitImage)
        self.addSubview(friendLabel)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitImage.translatesAutoresizingMaskIntoConstraints = false
        friendLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        friendLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        friendLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    
        fruitImage.leadingAnchor.constraint(equalTo: friendLabel.trailingAnchor, constant: 10).isActive = true
        fruitImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        fruitImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        fruitImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }

}

