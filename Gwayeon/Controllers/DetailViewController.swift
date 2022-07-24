//
//  DetailViewController.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    private lazy var fruitImageView: UIImageView = {
        let fruitImageView = UIImageView(image: UIImage(named: "peaches"))
        fruitImageView.contentMode = .scaleAspectFill
        return fruitImageView
    }()
    
    private lazy var fruitName: UILabel = {
        let name = UILabel()
        name.text = "대극천 복숭아"
        name.font = .systemFont(ofSize: 28, weight: .bold)
        name.textColor = .mainColor
        return name
    }()
    
    private lazy var farmName: UILabel = {
        let name = UILabel()
        name.text = "오로라 농장"
        name.font = .preferredFont(forTextStyle: .title3)
        return name
    }()
    
    private lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 30
        return whiteView
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 한마디"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    // UIButton.Configuration: ios 15에서 업데이트된 기능. more customizable.
    private lazy var messageButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.cornerStyle = .capsule
        config.background.strokeColor = .mainColor
        config.baseForegroundColor = .mainColor
        config.image = UIImage(systemName: "message")
        config.title = " 문자"
        config.attributedTitle?.font = .systemFont(ofSize: 17, weight: .bold)
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        return button
    }()
    
    private lazy var callButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .mainColor
        config.image = UIImage(systemName: "phone.fill")
        config.title = " 전화하기"
        config.attributedTitle?.font = .systemFont(ofSize: 17, weight: .bold)
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        return button
    }()
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
    }
    
    // MARK: Configures
    private func configureViewComponent() {
        view.backgroundColor = .peachColor
        
        [fruitImageView, fruitName, farmName, whiteView, recommendLabel, callButton, messageButton].forEach { component in
            view.addSubview(component)
            (component).translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let fruitNameConstraints = [
            fruitName.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 24),
            fruitName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
        
        let farmNameConstraints = [
            farmName.topAnchor.constraint(equalTo: fruitName.bottomAnchor, constant: 8),
            farmName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
        
        let whiteViewConstraints = [
            whiteView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.58),
            whiteView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        
        let recommendLabelConstraints = [
            recommendLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 48),
            recommendLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        
        let messageButtonConstraints = [
            messageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            messageButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            messageButton.heightAnchor.constraint(equalToConstant: 56),
            messageButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.35)
        ]
        
        let callButtonConstraints = [
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            callButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            callButton.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 8),
            callButton.heightAnchor.constraint(equalToConstant: 56),
            callButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.65)
        ]
        
        [fruitImageViewConstraints, fruitNameConstraints, farmNameConstraints, whiteViewConstraints, recommendLabelConstraints, messageButtonConstraints, callButtonConstraints].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
}
