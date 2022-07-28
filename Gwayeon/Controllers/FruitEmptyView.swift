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
        label.text = "아직 추천받은 과일이 없습니다"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "과연을 추가하면"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let canSeeLabel: UILabel = {
        let label = UILabel()
        label.text = "친구가 추천한 과일을 볼 수 있습니다"
        label.font = UIFont.systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private let findFriendLabel: UILabel = {
        let label = UILabel()
        label.text = "과연 찾아보기"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .mainColor
        return label
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        [emptyLabel, recommendLabel, canSeeLabel, findFriendLabel].forEach { component in
            self.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let emptyLabelConstraints = [
            emptyLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            emptyLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        let recommendLabelConstraints = [
            recommendLabel.topAnchor.constraint(equalTo: emptyLabel.bottomAnchor, constant: 20),
            recommendLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        let canSeeLabelConstraints = [
            canSeeLabel.topAnchor.constraint(equalTo: recommendLabel.bottomAnchor, constant: 20),
            canSeeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        let findFriendLabelConstraints = [
            findFriendLabel.topAnchor.constraint(equalTo: canSeeLabel.bottomAnchor, constant: 30),
            findFriendLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        ]
        
        [emptyLabelConstraints, recommendLabelConstraints, canSeeLabelConstraints, findFriendLabelConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }
}
