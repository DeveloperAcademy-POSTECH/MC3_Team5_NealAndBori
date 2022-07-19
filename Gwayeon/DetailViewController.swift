//
//  DetailViewController.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/19.
//

import UIKit

@IBDesignable
class DetailViewController: UIViewController {
    
    // MARK: Properties
    // UIButton.Configuration: ios 15에서 업데이트된 기능. more customizable.
    lazy var messageButton: UIButton = {
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
    
    lazy var callButton: UIButton = {
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
    func configureViewComponent() {
        view.backgroundColor = .white
        
        view.addSubview(messageButton)
        messageButton.translatesAutoresizingMaskIntoConstraints = false
        let messageButtonConstraints = [
            messageButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            messageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            messageButton.heightAnchor.constraint(equalToConstant: 56),
            messageButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.35)
        ]
        NSLayoutConstraint.activate(messageButtonConstraints)
        
        view.addSubview(callButton)
        callButton.translatesAutoresizingMaskIntoConstraints = false
        let callButtonConstraints = [
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            callButton.leadingAnchor.constraint(equalTo: messageButton.trailingAnchor, constant: 8),
            callButton.heightAnchor.constraint(equalToConstant: 56),
            callButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.65)
        ]
        NSLayoutConstraint.activate(callButtonConstraints)
    }
}
