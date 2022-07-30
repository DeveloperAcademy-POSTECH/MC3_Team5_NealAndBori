//
//  UsernameSettingViewController.swift
//  Gwayeon
//
//  Created by Heeji Sohn on 2022/07/25.
//

import UIKit

class UsernameSettingViewController: UIViewController {
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        return label
    }()
    
    private lazy var usernameTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        button.setTitle("다음", for: UIControl.State.normal)
        button.addTarget(nil, action: #selector(didTapNextButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        
        [usernameLabel, usernameTextfield, nextButton].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false

        }
        
        let usernameLabelConstraints = [
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 104),
            usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ]
        
        let usernameTextFieldConstraints = [
            usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 16),
            usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor,constant: 42), usernameTextfield.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            usernameTextfield.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        
        let nextButtonConstraints = [
            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -22),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            nextButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        [usernameLabelConstraints,usernameTextFieldConstraints,nextButtonConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
        
    }
    
    @objc private func didTapNextButton() {
        let userName = usernameTextfield.text
        let pinCodeMaker = { () -> String in
            let randomNum = Int.random(in: 0...9999)
            if randomNum >= 1000 {
                return "#" + String(randomNum)
            } else if randomNum >= 100 {
                return "#0" + String(randomNum)
            } else if randomNum >= 10 {
                return "#00" + String(randomNum)
            } else {
                return "#000" + String(randomNum)
            }
        }
        
        let pinCode = pinCodeMaker()
        
        let email = userName! + pinCode + "@gmail.com"
        let password = "nilandbories"
        
        print(email)
        
        Task { [weak self] in
            await FirebaseManager.shared.createNewAccount(email: email, password: password)
            await FirebaseManager.shared.storeUserInformation(email: email, userName: userName!, pinCode: pinCode, userImageName: "peach")
            self?.goHome()
        }
    }
    
    private func goHome() {
        let viewController = MainTabBarViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
}
