//
//  FriendAddViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/25.
//

import UIKit

class FriendAddViewController: UIViewController {
    
    // 검색 초기 화면, 결과 없을 때 화면, 결과 화면 구분하여 UI 구현하기 위함
    private enum ViewCase {
        case beforeSearch
        case noResult
        case showResult
    }
    
    private let selectCase : ViewCase = .noResult
    
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
    
    private let guideLabel : UILabel = {
        let label = UILabel()
        label.text = "과연을 찾아보세요"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        
        return label
    }()
    
    private let noResultTextStack : UIStackView = {
        let firstLineLabel = UILabel()
        let secondLineLabel = UILabel()
        
        firstLineLabel.text = "찾으시는 과연이 없습니다"
        secondLineLabel.text = "이름#0000 으로 검색해주세요"
        
        firstLineLabel.font = .systemFont(ofSize: 20, weight: .regular)
        secondLineLabel.font = .systemFont(ofSize: 20, weight: .regular)
        
        let stackView = UIStackView(arrangedSubviews: [firstLineLabel, secondLineLabel])
        stackView.spacing = 8
        stackView.axis = .vertical
        
        return stackView
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
        
        // 검색 초기 화면, 결과 없을 때 화면, 결과 화면 구분하여 UI 구현하기 위함
        if selectCase == .noResult {
            setupNoResultComponentLayout()
        }
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        [fruitImage, guideLabel, searchButton, searchTextField].forEach { component in
            self.view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageConstraints = [
            fruitImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 105),
            fruitImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fruitImage.widthAnchor.constraint(equalToConstant: 80),
            fruitImage.heightAnchor.constraint(equalToConstant: 80)
        ]
        
        let guideLabelConstraints = [
            guideLabel.topAnchor.constraint(equalTo: fruitImage.bottomAnchor, constant: 24),
            guideLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let searchButtonConstraints = [
            searchButton.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 32),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.widthAnchor.constraint(equalToConstant: 46),
            searchButton.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        let searchTextFieldConstraints = [
            searchTextField.topAnchor.constraint(equalTo: guideLabel.bottomAnchor, constant: 32),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchTextField.trailingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: -16),
            searchTextField.heightAnchor.constraint(equalToConstant: 46)
        ]
        
        [fruitImageConstraints, guideLabelConstraints, searchButtonConstraints, searchTextFieldConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }
    
    private func setupNoResultComponentLayout() {
        self.view.addSubview(noResultTextStack)
        noResultTextStack.translatesAutoresizingMaskIntoConstraints = false
        
        let noResultTextStackConstraints = [
            noResultTextStack.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 48),
            noResultTextStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(noResultTextStackConstraints)
    }

}
