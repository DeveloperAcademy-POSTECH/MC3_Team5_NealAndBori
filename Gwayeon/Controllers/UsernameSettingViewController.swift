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
        textField.addTarget(nil, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private lazy var nextButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        
        configuration.baseBackgroundColor = UIColor.mainColor
        configuration.background.cornerRadius = 12
        configuration.title = "다음"
        configuration.attributedTitle?.font = .systemFont(ofSize: 17, weight: .bold)
        
        let button = UIButton(configuration: configuration)
        button.isEnabled = false
        button.addTarget(nil, action: #selector(nextButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBackButton()
        hideKeyboardWhenTappedAround()
        setLayout()
    }
    
    @objc private func nextButtonClicked(_ sender: Any) {
        let userProfileCompletionViewController = UserProfileCompletionViewController()
        if let username = usernameTextfield.text,!username.isEmpty {
            userProfileCompletionViewController.username = username
            navigationController?.pushViewController(userProfileCompletionViewController, animated: true)
        } else {return}
    }
    
    @objc func textFieldDidChange(sender: UITextField) {
        if sender.text?.isEmpty == true {
            self.nextButton.isEnabled = false
        } else {
            self.nextButton.isEnabled = true
        }
    }
    
    private func setNavigationBackButton() {
        view.backgroundColor = .systemBackground
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .label
        self.navigationItem.backBarButtonItem = backBarButtonItem
    }
    
    private func setLayout() {
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
            nextButton.heightAnchor.constraint(equalToConstant: 55)
        ]
        
        [usernameLabelConstraints,usernameTextFieldConstraints,nextButtonConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
        
    }
    
}
