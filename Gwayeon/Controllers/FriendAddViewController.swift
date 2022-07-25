//
//  FriendAddViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/25.
//

import UIKit

class FriendAddViewController: UIViewController {
    
    private let searchTextField : UITextField = {
        let textField = UITextField()
        let placeholderText = "이름#0000 로 입력해 주세요"
        
        // textfield style
        textField.font = .systemFont(ofSize: 17, weight: .regular)
        textField.borderStyle = .roundedRect
        
        // placeholder style
        textField.attributedPlaceholder = NSAttributedString(
            string : placeholderText,
            attributes: [
                NSAttributedString.Key.foregroundColor : UIColor(hex: "8A8A8E"),
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
                    
        return textField
    }()
    
    private let searchButton : UIButton = {
        
        // button style
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "magnifyingglass")
        configuration.baseBackgroundColor = UIColor.mainRed
        configuration.background.cornerRadius = 10
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(searchTextField)
        self.view.addSubview(searchButton)
        
        [searchTextField, searchButton].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let searchButtonConstraints = [
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 46),
            searchButton.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        [searchButtonConstraints, searchTextFieldConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
