//
//  BottomSheetViewController.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/27.
//

import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK: Properties
    private lazy var fruitImageView: UIImageView = {
        let fruitImageView = UIImageView(image: UIImage(named: "peaches"))
        fruitImageView.contentMode = .scaleAspectFill
        
        return fruitImageView
    }()
    
    private lazy var requiredComment: UILabel = {
        let label = UILabel()
        label.text = "오로라 농장에 연락하셨네요. \n구매 리스트에 추가할까요?"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var noticedComment: UILabel = {
        let label = UILabel()
        label.text = "구매리스트에 자동으로 추가됩니다."
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.baseBackgroundColor = .systemGray2
        config.title = "아니요"
        config.attributedTitle?.font = .systemFont(ofSize: 20, weight: .bold)
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(backToFirstVC), for: .touchUpInside)
        return button
    }()
    
    private lazy var addButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.baseBackgroundColor = .mainColor
        config.title = "추가할게요"
        config.attributedTitle?.font = .systemFont(ofSize: 20, weight: .bold)
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        // 추가할게요 버튼 누르면 구매리스트에 지금 페이지의 정보가 추가되어야 함..
//        button.addTarget(self, action: #selector(), for: .touchUpInside)
        return button
    }()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
    }
    
    // MARK: Configure
    private func configureViewComponent() {
        view.backgroundColor = .white
        
        [fruitImageView, requiredComment, noticedComment, cancelButton, addButton].forEach { component in
            view.addSubviews(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            fruitImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let requiredCommentConstraints = [
            requiredComment.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 24),
            requiredComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let noticedCommentConstraints = [
            noticedComment.topAnchor.constraint(equalTo: requiredComment.bottomAnchor, constant: 8),
            noticedComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let cancelButtonConstraints = [
            cancelButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            cancelButton.heightAnchor.constraint(equalToConstant: 56),
            cancelButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.45)
        ]
        
        let addButtonConstraints = [
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addButton.leadingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 16),
            addButton.heightAnchor.constraint(equalToConstant: 56),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.5)
        ]
        
        [fruitImageViewConstraints, requiredCommentConstraints, noticedCommentConstraints, cancelButtonConstraints, addButtonConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
    }
    
    @objc func backToFirstVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
