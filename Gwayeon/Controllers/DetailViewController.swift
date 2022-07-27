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
        let label = UILabel()
        label.text = "대극천 복숭아"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .mainColor
        return label
    }()
    
    private lazy var farmName: UILabel = {
        let label = UILabel()
        label.text = "오로라 농장"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var recommandLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 한 마디"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
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
        
        [fruitImageView, fruitName, farmName, reviewListView, recommandLabel].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let fruitNameConstraints = [
            fruitName.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 16),
            fruitName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let farmNameConstraints = [
            farmName.topAnchor.constraint(equalTo: fruitName.bottomAnchor, constant: 8),
            farmName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
        
        let recommandLabelConstraints = [
            recommandLabel.topAnchor.constraint(equalTo: reviewListView.topAnchor, constant: 30),
            recommandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let reviewListViewConstraints = [
            reviewListView.topAnchor.constraint(equalTo: farmName.bottomAnchor, constant: 40),
            reviewListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            reviewListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            reviewListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        [fruitImageViewConstraints, fruitNameConstraints, farmNameConstraints, recommandLabelConstraints, reviewListViewConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
    }
}
