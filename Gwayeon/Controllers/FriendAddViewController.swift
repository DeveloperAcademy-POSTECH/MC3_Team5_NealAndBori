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
        
        textField.placeholder = "이름#0000 로 입력해 주세요"
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
        // Do any additional setup after loading the view.
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(searchTextField)
        
        searchTextField.translatesAutoresizingMaskIntoConstraints = false
        searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 78).isActive = true
        
    }

}
