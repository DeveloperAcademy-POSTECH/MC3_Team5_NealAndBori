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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -78),
            searchTextField.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        NSLayoutConstraint.activate(searchTextFieldConstraints)
        
    }

}
