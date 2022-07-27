//
//  FriendAddViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/25.
//

import UIKit

// temporary data
struct FriendResultData {
    let name : String
    let code : String
    let fruit : String
    let recommendsCount : Int
}

class FriendAddViewController: UIViewController {
    
    let friendSearchResult : [FriendResultData] = [FriendResultData(name: "이과연", code: "#1234", fruit: "apple", recommendsCount: 100)]
    
    // 검색 초기 화면, 결과 없을 때 화면, 결과 화면 구분하여 UI 구현, 확인하기 위해 임시로 사용
    private enum ViewCase {
        case beforeSearch
        case noResult
        case showResult
    }
    
    private let selectCase : ViewCase = .showResult
    
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
                NSAttributedString.Key.foregroundColor : UIColor.systemGray3,
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .regular)
            ]
        )
        
        return textField
    }()
    
    private let searchButton : UIButton = {
        // button style
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "magnifyingglass")
        configuration.baseBackgroundColor = UIColor.mainColor
        configuration.background.cornerRadius = 12
        
        let button = UIButton(configuration: configuration)
        
        return button
    }()
    
    private let fruitImage : UIImageView = {
        let mainImage = UIImage(named: "peach-1")
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
    
    private lazy var searchResultCellView : UIView = {
        let view = FriendAddResultCellView()
        view.configure(data: friendSearchResult[0])
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        
        // 검색 초기 화면, 결과 없을 때 화면, 결과 화면 구분하여 UI 구현, 확인하기 위해 임시로 사용
        if selectCase == .beforeSearch {
            noResultTextStack.isHidden = true
            searchResultCellView.isHidden = true
        } else if selectCase == .noResult {
            noResultTextStack.isHidden = false
            searchResultCellView.isHidden = true
        } else if selectCase == .showResult {
            noResultTextStack.isHidden = true
            searchResultCellView.isHidden = false
        }
    }
    
    private func setLayout() {
        view.backgroundColor = .systemBackground
        
        [fruitImage, guideLabel, searchButton, searchTextField, noResultTextStack, searchResultCellView].forEach { component in
            self.view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // 고정 UI
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
        
        // 검색 결과 없을 때 UI
        let noResultTextStackConstraints = [
            noResultTextStack.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 48),
            noResultTextStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        // 검색 결과 있을 때 UI
        let searchResultCellViewConstraints = [
            searchResultCellView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 40),
            searchResultCellView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        [fruitImageConstraints, guideLabelConstraints, searchButtonConstraints, searchTextFieldConstraints, noResultTextStackConstraints, searchResultCellViewConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
