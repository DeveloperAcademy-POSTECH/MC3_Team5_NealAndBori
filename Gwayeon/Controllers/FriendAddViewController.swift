//
//  FriendAddViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/25.
//

import UIKit
import Foundation

class FriendAddViewController: UIViewController {
    
    var friendSearchResult = [User]()
    
    // 검색 초기 화면, 결과 없을 때 화면, 결과 화면 구분하여 UI 구현, 확인하기 위해 임시로 사용
    private enum ViewCase {
        case beforeSearch
        case noResult
        case showResult
    }
    
    private var selectCase : ViewCase = .beforeSearch
    
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
    
    private lazy var searchButton : UIButton = {
        // button style
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "magnifyingglass")
        configuration.baseBackgroundColor = UIColor.mainColor
        configuration.background.cornerRadius = 12
        
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(searchFriend), for: .touchUpInside)
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
    
    private let searchResultCellView = FriendAddResultCellView()
    
    private lazy var addButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.baseBackgroundColor = UIColor.mainColor
        configuration.background.cornerRadius = 12
        configuration.title = "추가"
        configuration.attributedTitle?.font = .systemFont(ofSize: 24, weight: .medium)
        
        let button = UIButton(configuration: configuration)
        button.isEnabled = false
        button.addTarget(self, action: #selector(addFriend), for: .touchUpInside) // TODO: 과연 추가 서버 구현 이후 추가 예정
        return button
    }()
    
    private lazy var customNavigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar()
        // 네비게이션 바 배경 색깔 제거, 강조색 설정
        navigationBar.barTintColor = .systemBackground
        navigationBar.tintColor = .mainRed
        // 네비게이션 바 아래 구분선 제거
        navigationBar.shadowImage = UIImage()
        // 타이틀, 취소 버튼 추가
        let navigationItem = UINavigationItem(title: "과연 추가")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(closeModal))
        navigationBar.items = [navigationItem]
        return navigationBar
    }()
    
    @objc private func closeModal() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func searchFriend() {
        // 이전 검색 결과 삭제
        friendSearchResult.removeAll()
        
        // 검색 format에 맞는지 확인 (이름#0000)
        let searchText = searchTextField.text
        let patternNameCode = "^([가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9_]{1,})#([0-9]{4})$"
        let patternCheck = searchText?.range(of: patternNameCode, options: .regularExpression) != nil
        // 검색 format에 맞지 않는다면 검색 수행하지 않고 결과 없음 출력
        if !patternCheck {
            self.showNoResultView()
            return
        }
        
        // TODO: pincode, username 으로 검색하기 (서버 구현 후 변경)
        // 검색 텍스트 이름과 UID로 분리 후 UID로 검색
        guard let seperatedSearchText = searchText?.components(separatedBy: "#")
        else {
            return
        }
        
        // 검색 결과가 nil이 아니라면 결과 출력, 결과가 nil이거나 error 발생시 결과 없음 출력
        FirebaseManager.shared.fetchUserInformation(userName: seperatedSearchText[0], pinCode: seperatedSearchText[1]) { results in
            switch results {
            case .success(let users):
                if (!users.isEmpty) {
                    self.showResultView(users: users)
                } else {
                    self.showNoResultView()
                }
            case .failure(let error):
                self.showNoResultView()
            }
        }
    }
    
    @objc private func addFriend() {
        // TODO: uid 가져오는 함수 활용하기
//        guard let uid = "RyEgFAfzMZoVfBySIekD", let friendId = friendSearchResult[0].id else {
//            return
//        }
        guard let friendId = friendSearchResult[0].id else {
            return
        }
        let uid = "RyEgFAfzMZoVfBySIekD"
        
        FirebaseManager.shared.requestFriendAddition(uid: uid, friendId: friendId)
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "과연 추가"
        self.navigationController?.navigationBar.tintColor = .mainColor
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(closeModal))
    }
    
    private func showResultView(users : [User]) {
        self.friendSearchResult.append(contentsOf: users)
        self.searchResultCellView.isHidden = false
        self.noResultTextStack.isHidden = true
        self.searchResultCellView.configure(data: users[0])
        self.addButton.isEnabled = true
    }
    
    private func showNoResultView() {
        self.searchResultCellView.isHidden = true
        self.noResultTextStack.isHidden = false
        self.addButton.isEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        setLayout()
        setNavigationBar()
        // 초기 검색 화면만 보이도록 설정
        noResultTextStack.isHidden = true
        searchResultCellView.isHidden = true
    }
    
    private func setLayout() {
        view.backgroundColor = .systemBackground
        
        view.addSubviews(fruitImage, guideLabel, searchButton, searchTextField, noResultTextStack, searchResultCellView, addButton)
        
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
        
        // 추가 버튼
        let addButtonConstraints = [
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.heightAnchor.constraint(equalToConstant: 60)
        ]
        
        [fruitImageConstraints, guideLabelConstraints, searchButtonConstraints, searchTextFieldConstraints,
         noResultTextStackConstraints, searchResultCellViewConstraints, addButtonConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }

}
