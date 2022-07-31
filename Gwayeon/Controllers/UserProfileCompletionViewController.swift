//
//  UserProfileCompletionViewController.swift
//  Gwayeon
//
//  Created by Heeji Sohn on 2022/07/26.
//

import UIKit

class UserProfileCompletionViewController: UIViewController {
    
    var username : String = ""
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        let categoryImage = ["apple", "pear", "tangerine", "watermelon", "grape", "peach-1", "tomato", "plum", "blueberry", "strawberry", "korean_melon", "melon", "kiwi", "fig", "mango", "persimmon", "other"]
        let randomNumber = Int.random(in: 0...categoryImage.count)
        imageView.image = UIImage(named: categoryImage[randomNumber])
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()//피그마에 있는 shadow가 좀 구린것같아서 디자인 수정 후 나중에 추가 예정
    
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    private let secondusernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private let profileCompletionLabel: UILabel = {
        let label = UILabel()
        label.text = "님의 프로필을 완성하였습니다!"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }()
    
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(secondusernameLabel)
        stackView.addArrangedSubview(profileCompletionLabel)
        return stackView
    }()
    
    private let withGwayeonLabel: UILabel = {
        let label = UILabel()
        let str = "이제 과연과\n농산물 직거래를 함께하세요"
        label.numberOfLines = 2
        label.textAlignment = .center
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        attributeString.setColor(color: .pointColor, forText: "과연")
        label.attributedText = attributeString
        return label
    }()
    
    private let profileEditableMessageLabel: UILabel = {
        let label = UILabel()
        label.text="※ 설정 페이지에서 프로필을 수정할 수 있습니다"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    private let gwayeonStartButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = .mainColor
        button.setTitle("시작하기", for: UIControl.State.normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = username
        secondusernameLabel.text = username
        setLayout()
    }
    
    private func setLayout() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(profileImageView, usernameLabel, sectionStackView, withGwayeonLabel,profileEditableMessageLabel,gwayeonStartButton)
        
        let profileImageViewConstraints = [
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 150),
            profileImageView.heightAnchor.constraint(equalToConstant: 150)
        ]
        
        let usernameLabelConstraints = [
            usernameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 24),
            usernameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let sectionStackViewConstraints = [
            sectionStackView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 32),
            sectionStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let withGwayeonLabelConstraints = [
            withGwayeonLabel.topAnchor.constraint(equalTo: profileCompletionLabel.bottomAnchor, constant: 24),
            withGwayeonLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let profileEditableMessageLabelConstraints = [
            profileEditableMessageLabel.bottomAnchor.constraint(equalTo: gwayeonStartButton.topAnchor,constant:-16),
            profileEditableMessageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let gwayeonStartButtonConstraints = [
            gwayeonStartButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            gwayeonStartButton.heightAnchor.constraint(equalToConstant: 50),
            gwayeonStartButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            gwayeonStartButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        [profileImageViewConstraints, usernameLabelConstraints, sectionStackViewConstraints, withGwayeonLabelConstraints, profileEditableMessageLabelConstraints, gwayeonStartButtonConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
        
    }
    
}
