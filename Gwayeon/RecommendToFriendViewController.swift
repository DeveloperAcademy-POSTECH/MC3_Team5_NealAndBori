//
//  RecommendToFriendViewController.swift
//  Gwayeon
//
//  Created by Heeji Sohn on 2022/07/19.
//

import UIKit

class RecommendToFriendViewController: UIViewController, UITextViewDelegate {

    // MARK: Properties
    lazy var farmLabel:UILabel = {
       let label = UILabel()
        label.text = "자연농원의"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()

    lazy var fruitLabel:UILabel = {
       let label = UILabel()
        label.text = "청송사과"
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
    let textViewPlaceHolder = "텍스트를 입력하세요"
    lazy var textView: UITextView = {
                let textView = UITextView()
                textView.delegate = self
                textView.textColor = UIColor.placeholderText
                textView.text = textViewPlaceHolder
                textView.font = UIFont.preferredFont(forTextStyle: .body)
                textView.adjustsFontForContentSizeCategory = true
                textView.isScrollEnabled = false
                textView.layer.cornerRadius = 5
                textView.layer.backgroundColor = UIColor.systemGray6.cgColor
                textView.layer.borderColor = UIColor.systemGray5.cgColor
                textView.layer.borderWidth = 0.5
                textView.clipsToBounds = true
                textView.isScrollEnabled = true
                
                return textView
            }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("test") //test
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
        
        farmLabel.translatesAutoresizingMaskIntoConstraints = false
        fruitLabel.translatesAutoresizingMaskIntoConstraints = false
        myFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        numOfFriendsLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
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
        textView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
    }

}
