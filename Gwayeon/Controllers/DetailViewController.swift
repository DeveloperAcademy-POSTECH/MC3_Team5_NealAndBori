//
//  DetailViewController.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/19.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: Properties
    private lazy var fruitImageView: UIImageView = {
        let fruitImageView = UIImageView(image: UIImage(named: "peaches"))
        fruitImageView.contentMode = .scaleAspectFill
        return fruitImageView
    }()
    
    private lazy var fruitName: UILabel = {
        let name = UILabel()
        name.text = "대극천 복숭아"
        name.font = .systemFont(ofSize: 28, weight: .bold)
        name.textColor = .mainColor
        return name
    }()
    
    private lazy var farmName: UILabel = {
        let name = UILabel()
        name.text = "오로라 농장"
        name.font = .preferredFont(forTextStyle: .title3)
        
        return name
    }()
    
    private let reviewListView = ReviewCollectionView()
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
    }
    
    // MARK: Configures
    private func configureViewComponent() {
        view.backgroundColor = .peachColor
        
        [fruitImageView, fruitName, farmName, reviewListView].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let fruitNameConstraints = [
            fruitName.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 24),
            fruitName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let farmNameConstraints = [
            farmName.topAnchor.constraint(equalTo: fruitName.bottomAnchor, constant: 8),
            farmName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let reviewListViewConstraints = [
            reviewListView.topAnchor.constraint(equalTo: farmName.bottomAnchor, constant: 40),
            reviewListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            reviewListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            reviewListView.heightAnchor.constraint(equalTo: view.heightAnchor, constant: 0)
        ]
        
        [fruitImageViewConstraints, fruitNameConstraints, farmNameConstraints, reviewListViewConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
    }
}
