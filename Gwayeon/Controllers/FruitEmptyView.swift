//
//  FruitEmptyView.swift
//  Gwayeon
//
//  Created by COBY_PRO on 2022/07/26.
//

import UIKit

final class FruitEmptyView: UIView {
    
    // MARK: - property
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.text = "추천받은 과일이 없어요."
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "과연을 추가하여 과일을 추천받아 보세요!"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let findFriendLabel: UILabel = {
        let label = UILabel()
        label.text = "과연 찾아보기"
        label.font = UIFont.systemFont(ofSize: 17, weight: .light)
        label.textColor = .red001
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewLayout() {
        [emptyLabel, recommendLabel, findFriendLabel].forEach { component in
            self.addSubview(component)
        }
        
        emptyLabel.translatesAutoresizingMaskIntoConstraints = false
        let emptyLabelConstraints = [
            emptyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            emptyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
        let recommendLabelConstraints = [
            recommendLabel.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 20),
            recommendLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        findFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        let findFriendLabelConstraints = [
            findFriendLabel.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor, constant: 30),
            findFriendLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        [emptyLabelConstraints, recommendLabelConstraints, findFriendLabelConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }
}
