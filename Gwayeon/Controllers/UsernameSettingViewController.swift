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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    private func configureLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(usernameLabel)
        view.addSubview(usernameTextfield)
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameTextfield.translatesAutoresizingMaskIntoConstraints = false
        
        usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 104).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        usernameTextfield.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor,constant: 16).isActive = true
        usernameTextfield.bottomAnchor.constraint(equalTo: usernameTextfield.topAnchor,constant: 32).isActive = true
        usernameTextfield.leftAnchor.constraint(equalTo: usernameLabel.leftAnchor, constant: 4).isActive = true
        usernameTextfield.rightAnchor.constraint(equalTo: usernameLabel.rightAnchor, constant: -4).isActive = true
    }
    
}
