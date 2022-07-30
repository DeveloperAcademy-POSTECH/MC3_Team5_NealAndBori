//
//  TestViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import UIKit

class TestViewController: UIViewController {
    
    private let uidTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "uid를 입력해주세요"
        
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
    
    
    private let pinCodeTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "pinCode를 입력해주세요"
        
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
    
    private let usernameTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "userName을 입력해주세요"
        
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
        fetchData(uid: uidTextField.text, pinCode: pinCodeTextField.text, userName: usernameTextField.text)
    }
    
    @objc private func setUserInfoButtonClicked(_ sender: Any) {
        sendUserData(pinCode: pinCodeTextField.text, userName: usernameTextField.text)
    }
    
    @objc private func setRecommendButtonClicked(_ sender: Any) {
        sendRecommend(uid: uidTextField.text, userName: usernameTextField.text, comment: recommendationTextField.text)
    }
    
    private func sendRecommend(uid: String?, userName: String?, comment: String?) {
        guard let uid = uid, let userName = userName, let comment = comment else {
            return
        }
        FirebaseManager.shared.requestRecommend(userId: uid, userName: userName, fruitId: "2233", comment: comment)
    }
    private func sendUserData(pinCode: String?, userName: String?) {
        guard let pinCode = pinCode, let userName = userName else {
            return
        }
        FirebaseManager.shared.requestUserInformation(userName: userName, pinCode: pinCode)
    }
    
    private func fetchData(uid: String?, pinCode: String?, userName: String?) {
        guard let uid = uid, !uid.isEmpty else {
            return
        }
//        FirebaseManager.shared.fetchUserInformation(uid: uid) { results in
//            switch results {
//            case .success(let user):
//                print(user)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
        guard let pinCode = pinCode, let userName = userName, !pinCode.isEmpty, !userName.isEmpty else {
            return
        }
//
//        FirebaseManager.shared.fetchUserInformation(userName: userName, pinCode: pinCode) { results in
//            switch results {
//            case .success(let users):
//                print(users)
//            case .failure(let error):
//                print(error)
//            }
//        }
//
//        FirebaseManager.shared.fetchRecommendInformation(userName: userName, pinCode: pinCode) { results in
//            switch results {
//            case .success(let recommends):
//                print(recommends)
//            case .failure(let error):
//                print(error)
//            }
//        }
        
        FirebaseManager.shared.fetchRecommendInformation(uid: uid) { results in
            switch results {
            case .success(let recommends):
                print(recommends)
            case .failure(let error):
                print(error)
            }
        }
        
        FirebaseManager.shared.fetchRecommendInformation(recommendId: pinCode) { results in
            switch results {
            case .success(let recommend):
                print(recommend)
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
        
        view.addSubviews(uidTextField, pinCodeTextField, usernameTextField, recommendationTextField, setRecommendButton, getUserButton, setUserButton)
        
        let uidTextFieldConstraints = [
            uidTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            uidTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            uidTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            uidTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let pinCodeTextFieldConstraints = [
            pinCodeTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pinCodeTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pinCodeTextField.topAnchor.constraint(equalTo: uidTextField.bottomAnchor, constant: 30),
            pinCodeTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let userNameTextFieldConstraints = [
            usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            usernameTextField.topAnchor.constraint(equalTo: pinCodeTextField.bottomAnchor, constant: 30),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let recommendTextFieldConstraints = [
            recommendationTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            recommendationTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            recommendationTextField.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 30),
            recommendationTextField.heightAnchor.constraint(equalToConstant: 50)
        ]
        let getUserButtonConstraints = [
            getUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            getUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            getUserButton.topAnchor.constraint(equalTo: recommendationTextField.bottomAnchor, constant: 20)
        ]
        
        let setUserButtonConstraints = [
            setUserButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            setUserButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            setUserButton.topAnchor.constraint(equalTo: getUserButton.bottomAnchor, constant: 20)
        ]
        
        let setRecommendButtonConstraints = [
            setRecommendButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            setRecommendButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            setRecommendButton.topAnchor.constraint(equalTo: setUserButton.bottomAnchor, constant: 20)
        ]
        
        [uidTextFieldConstraints, pinCodeTextFieldConstraints, userNameTextFieldConstraints, recommendTextFieldConstraints, getUserButtonConstraints, setUserButtonConstraints, setRecommendButtonConstraints].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
}
