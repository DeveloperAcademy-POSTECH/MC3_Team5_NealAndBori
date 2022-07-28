//
//  RecommendToFriendViewController.swift
//  Gwayeon
//
//  Created by Heeji Sohn on 2022/07/19.
//

import UIKit

class RecommendToFriendViewController: UIViewController {
    
    // MARK: Properties
    let textViewPlaceHolder = "가격, 맛, 배송에 대한 정보를 알려주면 내 친구들이 더 쉽게 살 수 있어요!"
    private lazy var farmLabel: UILabel = {
        let label = UILabel()
        label.text = "자연농원의"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var fruitLabel: UILabel = {
        let label = UILabel()
        label.text = "청송사과"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        return label
    }()
    
    private lazy var objLabel: UILabel = {
        let label = UILabel()
        label.text = "를"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var myFriendsLabel: UILabel = {
        let label = UILabel()
        label.text = "내 과연"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var numOfFriendsLabel: UILabel = {
        let label = UILabel()
        label.text = "213"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        return label
    }()
    
    private lazy var recommendLabel: UILabel = {
        let label = UILabel()
        label.text = " 명에게 추천합니다"
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var recommendMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 한마디"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(red: 0.506, green: 0.506, blue: 0.506, alpha: 1)
        
        return label
    }()
    
    lazy private var completionButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        button.setTitle("완료", for: UIControl.State.normal)
        button.addTarget(self, action: #selector(completeButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.backgroundColor = UIColor.systemGray6.cgColor
        textView.layer.cornerRadius = 5
        textView.textContainerInset = UIEdgeInsets(top: 16.0, left: 16.0, bottom: 16.0, right: 16.0)
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.text = textViewPlaceHolder
        textView.textColor = UIColor.placeholderText
        textView.adjustsFontForContentSizeCategory = true
        textView.clipsToBounds = true
        textView.delegate = self
        
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "과연에게 추천하기"
        // Do any additional setup after loading the view.
        setComponentLayouts()
    }
    
    private func setComponentLayouts() {
        view.backgroundColor = .systemBackground
        
        [farmLabel, fruitLabel, objLabel, myFriendsLabel, numOfFriendsLabel, recommendLabel, recommendMessageLabel, textView, completionButton].forEach { component in
            view.addSubview(component)
        }
        
        [farmLabel, fruitLabel, objLabel, myFriendsLabel, numOfFriendsLabel, recommendLabel, recommendMessageLabel, textView, completionButton].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let farmLabelConstraints = [
            farmLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 149),
            farmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ]
        
        let fruitLabelConstraints = [
            fruitLabel.bottomAnchor.constraint(equalTo: farmLabel.bottomAnchor),
            fruitLabel.leftAnchor.constraint(equalTo: farmLabel.rightAnchor, constant: 7)
        ]
        
        let objLabelConstraints = [
            objLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 149),
            objLabel.leftAnchor.constraint(equalTo: fruitLabel.rightAnchor)
        ]
        
        let myFriendsLabelConstraints = [
            myFriendsLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor,constant: 11),
            myFriendsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ]
        
        let numOfFriendsLabelConstraints = [
            numOfFriendsLabel.bottomAnchor.constraint(equalTo: myFriendsLabel.bottomAnchor, constant: 5),
            numOfFriendsLabel.leftAnchor.constraint(equalTo: myFriendsLabel.rightAnchor,constant: 8)
        ]
        
        let recommendLabelConstraints = [
            recommendLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor,constant: 11),
            recommendLabel.leftAnchor.constraint(equalTo: numOfFriendsLabel.rightAnchor, constant: 1)
        ]
        
        let recommendMessageLabelConstraints = [
            recommendMessageLabel.topAnchor.constraint(equalTo: myFriendsLabel.bottomAnchor, constant: 50),
            recommendMessageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16)
        ]
        
        let textViewConstraints = [
            textView.topAnchor.constraint(equalTo: recommendMessageLabel.bottomAnchor, constant: 13),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 161)
        ]
        
        let completionButtonConstraints = [
            completionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            completionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            completionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            completionButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        [farmLabelConstraints, fruitLabelConstraints, objLabelConstraints, myFriendsLabelConstraints, numOfFriendsLabelConstraints, recommendLabelConstraints, recommendMessageLabelConstraints, textViewConstraints, completionButtonConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    @objc private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
    }
    
    @objc private func completeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
}

extension RecommendToFriendViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = textViewPlaceHolder
            textView.textColor = .lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let inputString = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let oldString = textView.text, let newRange = Range(range, in: oldString) else { return true }
        let newString = oldString.replacingCharacters(in: newRange, with: inputString).trimmingCharacters(in: .whitespacesAndNewlines)
        
        let characterCount = newString.count
        guard characterCount <= 700 else { return false }
        
        return true
    }
}
