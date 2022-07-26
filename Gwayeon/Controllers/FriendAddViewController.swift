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
    
    private let fruitImage : UIImageView = {
        let mainImage = UIImage(named: "peach")
        
        let imageView = UIImageView(image: mainImage)
        
        imageView.contentMode = UIView.ContentMode.scaleAspectFit
        
        return imageView
    }()
    
    private let guideText : UILabel = {
        let label = UILabel()
        label.text = "과연을 찾아보세요"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        [fruitImage, guideText, searchTextField, searchButton].forEach { component in
            self.view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageConstraints = [
            fruitImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105),
            fruitImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fruitImage.widthAnchor.constraint(equalToConstant: 80),
            fruitImage.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let guideTextConstraints = [
            guideText.topAnchor.constraint(equalTo: fruitImage.bottomAnchor, constant: 24),
            guideText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let searchButtonConstraints = [
            searchButton.topAnchor.constraint(equalTo: guideText.bottomAnchor, constant: 32),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 46),
            searchButton.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: guideText.bottomAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        [fruitImageConstraints, guideTextConstraints, searchButtonConstraints, searchTextFieldConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
