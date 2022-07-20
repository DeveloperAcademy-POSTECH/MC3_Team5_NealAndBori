//
//  RecommendToFriendViewController.swift
//  Gwayeon
//
//  Created by Heeji Sohn on 2022/07/19.
//

import UIKit

class RecommendToFriendViewController: UIViewController {
    
    // MARK: Properties
    lazy var farmLabel:UILabel = {
        let label = UILabel()
        label.text = "자연농원의"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var fruitLabel:UILabel = {
        let label = UILabel()
        label.text = "청송사과를"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        return label
    }()
    
    lazy var myFriendsLabel:UILabel = {
        let label = UILabel()
        label.text = "내 과연"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var numOfFriendsLabel:UILabel = {
        let label = UILabel()
        label.text = "213"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        return label
    }()
    
    lazy var recommendLabel:UILabel = {
        let label = UILabel()
        label.text = " 명에게 추천합니다"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var recommendMessageLabel:UILabel = {
        let label = UILabel()
        label.text = "추천 한마디"
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(red: 0.506, green: 0.506, blue: 0.506, alpha: 1)
        
        return label
    }()
    
    lazy var completionButton:UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 0.965, green: 0.408, blue: 0.369, alpha: 1)
        button.setTitle("완료", for: UIControl.State.normal)
        
        return button
    }()
    
    let textViewPlaceHolder = "가격, 맛, 배송에 대한 정보를 알려주면 내 친구들이 더 쉽게 살 수 있어요!"
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
        // Do any additional setup after loading the view.
        configureViewComponent()
    }
    
    func configureViewComponent() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(farmLabel)
        view.addSubview(fruitLabel)
        view.addSubview(myFriendsLabel)
        view.addSubview(numOfFriendsLabel)
        view.addSubview(recommendLabel)
        view.addSubview(recommendMessageLabel)
        view.addSubview(textView)
        view.addSubview(completionButton)

        farmLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitLabel.translatesAutoresizingMaskIntoConstraints = false
        myFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        numOfFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        completionButton.translatesAutoresizingMaskIntoConstraints = false
        
        farmLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 149).isActive = true
        farmLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        fruitLabel.bottomAnchor.constraint(equalTo: farmLabel.bottomAnchor).isActive = true
        fruitLabel.leftAnchor.constraint(equalTo: farmLabel.rightAnchor, constant: 7).isActive = true
        
        myFriendsLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor,constant: 11).isActive = true
        myFriendsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        numOfFriendsLabel.bottomAnchor.constraint(equalTo: myFriendsLabel.bottomAnchor, constant: 5).isActive = true
        numOfFriendsLabel.leftAnchor.constraint(equalTo: myFriendsLabel.rightAnchor,constant: 8).isActive = true
        
        recommendLabel.topAnchor.constraint(equalTo: farmLabel.bottomAnchor,constant: 11).isActive = true
        recommendLabel.leftAnchor.constraint(equalTo: numOfFriendsLabel.rightAnchor, constant: 1).isActive = true
        
        recommendMessageLabel.topAnchor.constraint(equalTo: myFriendsLabel.bottomAnchor, constant: 50).isActive = true
        recommendMessageLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        textView.topAnchor.constraint(equalTo: recommendMessageLabel.bottomAnchor, constant: 13).isActive = true
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 161).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapTextView(_:)))
        view.addGestureRecognizer(tapGesture)
        
        completionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5).isActive = true
        completionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        completionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        completionButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    @objc
    private func didTapTextView(_ sender: Any) {
        view.endEditing(true)
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
