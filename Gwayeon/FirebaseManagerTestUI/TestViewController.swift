//
//  TestViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import UIKit

class TestViewController: UIViewController {
    
    private let userIDTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "user id를 입력해주세요"
        
        // textfield style
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect

        // placeholder style
        textField.attributedPlaceholder = NSAttributedString(
            string : placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.systemGray3,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
        return textField
    }()
    
    private let nicknameTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "nickname을 입력해주세요"
        
        // textfield style
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect

        // placeholder style
        textField.attributedPlaceholder = NSAttributedString(
            string : placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.systemGray3,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
        return textField
    }()
    
    private let recommendationTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "추천이유를 입력해주세요"
        
        // textfield style
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect

        // placeholder style
        textField.attributedPlaceholder = NSAttributedString(
            string : placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor.systemGray3,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
        return textField
    }()
    
    lazy private var getUserButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.buttonSize = .large
        config.title = "유저정보 입력받기"
        btn.configuration = config
        btn.addTarget(self, action: #selector(getUserInfoButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy private var setUserButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .red
        config.buttonSize = .large
        config.title = "유저정보 입력하기"
        btn.configuration = config
        btn.addTarget(self, action: #selector(setUserInfoButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    lazy private var setRecommendButton: UIButton = {
        let btn = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .red
        config.buttonSize = .large
        config.title = "추천이유 입력하기"
        btn.configuration = config
        btn.addTarget(self, action: #selector(setRecommendButtonClicked(_:)), for: .touchUpInside)
        return btn
    }()
    
    
    @objc private func getUserInfoButtonClicked(_ sender: Any) {
        fetchData(uid: userIDTextField.text, nickname: nicknameTextField.text)
    }
    
    @objc private func setUserInfoButtonClicked(_ sender: Any) {
        sendData(uid: userIDTextField.text, nickname: nicknameTextField.text)
    }
    
    @objc private func setRecommendButtonClicked(_ sender: Any) {
        sendRecommend(uid: userIDTextField.text, nickname: nicknameTextField.text, recommend: recommendationTextField.text)
    }
    
    private func sendRecommend(uid: String?, nickname: String?, recommend: String?) {
        guard let uid = uid, let nickname = nickname, let recommend = recommend else {
            return
        }
        FirebaseManager.shared.sendRecommend(uid: uid, nickname: nickname, fruitID: "234234", comment: recommend)
    }
    private func sendData(uid: String?, nickname: String?) {
        guard let uid = uid, let nickname = nickname else {
            return
        }
        FirebaseManager.shared.sendUserInformation(uid: uid, nickname: nickname)
    }
    
    private func fetchData(uid: String?, nickname: String?) {
        
        guard let uid = uid else {
            return
        }

        FirebaseManager.shared.getUserInformation(uid: uid) { results in
            switch results {
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error)
            }
        }
        
        guard let nickname = nickname else {
            return
        }
        FirebaseManager.shared.getRecommendInformation(uid: uid, nickname: nickname) { results in
            switch results {
            case .success(let recommends):
                print(recommends)
            case .failure(let error):
                print(error)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.navigationItem.title = "Firebase Test Page"
        self.navigationItem.largeTitleDisplayMode = .always
        self.navigationController?.navigationBar.prefersLargeTitles = true

        setLayouts()
    }
    
    private func setLayouts() {
        
        view.addSubviews(userIDTextField, nicknameTextField, recommendationTextField, setRecommendButton, getUserButton, setUserButton)
        
        let userIDTextFieldConstraints = [
            userIDTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            userIDTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            userIDTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            userIDTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let nicknameTextFieldConstraints = [
            nicknameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            nicknameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            nicknameTextField.topAnchor.constraint(equalTo: userIDTextField.bottomAnchor, constant: 50),
            nicknameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let recommendTextFieldConstraints = [
            recommendationTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recommendationTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recommendationTextField.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 50),
            recommendationTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        let getUserButtonConstraints = [
            getUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            getUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            getUserButton.topAnchor.constraint(equalTo: recommendationTextField.bottomAnchor, constant: 50)
        ]
        
        let setUserButtonConstraints = [
            setUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            setUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            setUserButton.topAnchor.constraint(equalTo: getUserButton.bottomAnchor, constant: 50)
        ]
        
        let setRecommendButtonConstraints = [
            setRecommendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            setRecommendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            setRecommendButton.topAnchor.constraint(equalTo: setUserButton.bottomAnchor, constant: 50)
        ]
        
        [userIDTextFieldConstraints, nicknameTextFieldConstraints, recommendTextFieldConstraints, getUserButtonConstraints, setUserButtonConstraints, setRecommendButtonConstraints].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
}
