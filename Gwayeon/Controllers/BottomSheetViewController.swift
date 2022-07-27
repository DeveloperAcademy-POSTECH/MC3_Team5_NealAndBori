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
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var noticedComment: UILabel = {
        let label = UILabel()
        label.text = "구매리스트에 자동으로 추가됩니다."
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    // MARK: Init
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponent()
    }
    
    // MARK: Configure
    private func configureViewComponent() {
        view.backgroundColor = .white
        
        [fruitImageView, requiredComment, noticedComment].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            fruitImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let requiredCommentConstraints = [
            requiredComment.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 24),
            requiredComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        let noticedCommentConstraints = [
            noticedComment.topAnchor.constraint(equalTo: requiredComment.bottomAnchor, constant: 16),
            noticedComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24)
        ]
        
        [fruitImageViewConstraints, requiredCommentConstraints, noticedCommentConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
    }
}
