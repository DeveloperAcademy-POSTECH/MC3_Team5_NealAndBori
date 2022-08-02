//
//  HomeViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var recommendFruits: [RecommendFruit]? = []
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 20.0
        static let collectionVerticalSpacing: CGFloat = 20.0
        static let cellWidth: CGFloat = UIScreen.main.bounds.size.width - collectionHorizontalSpacing * 2
        static let cellHeight: CGFloat = 184
        static let collectionInset = UIEdgeInsets(top: collectionVerticalSpacing,
                                                  left: collectionHorizontalSpacing,
                                                  bottom: collectionVerticalSpacing,
                                                  right: collectionHorizontalSpacing)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "과일 둘러보기"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    
    private let fruitListView = FruitListView()
    
    private let fruitEmptyView = FruitEmptyView()
    
    private lazy var findFriendLabel: UILabel = {
        let label = UILabel()
        label.text = "과연 찾아보기"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = .mainColor
        // label에 과연 추가 sheet 연결 위한 tap gesture 추가
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = Size.collectionInset
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 16
        return flowLayout
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FarmCollectionViewCell.self,
                                forCellWithReuseIdentifier: FarmCollectionViewCell.identifier)
        return collectionView
    }()
    
    @objc private func tapFunction() {
        let viewController = FriendAddViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
        
        Task { [weak self] in
            self?.recommendFruits = await FirebaseManager.shared.getFruits()
            print(self?.recommendFruits)
            
            DispatchQueue.main.async {
                self?.collectionViewFlowLayout.collectionView?.reloadData()
                
                if ((self?.recommendFruits?.isEmpty) != nil) {
                    self?.fruitEmptyView.isHidden = true
                    self?.findFriendLabel.isHidden = true
                }
            }
        }
    }
    
    // MARK: Configures
    private func configureViewComponent() {
        view.backgroundColor = .white
                
        [titleLabel, fruitListView, fruitEmptyView, listCollectionView, findFriendLabel].forEach { component in
            view.addSubview(component)
        }
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        fruitListView.translatesAutoresizingMaskIntoConstraints = false
        let fruitListViewConstraints = [
            fruitListView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            fruitListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fruitListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fruitListView.heightAnchor.constraint(equalToConstant: 45)
        ]
        
        fruitEmptyView.translatesAutoresizingMaskIntoConstraints = false
        let fruitEmptyViewConstraints = [
            fruitEmptyView.topAnchor.constraint(equalTo: fruitListView.bottomAnchor, constant: 66),
            fruitEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fruitEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fruitEmptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        findFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        let findFriendLabelConstraints = [
            findFriendLabel.topAnchor.constraint(equalTo: fruitEmptyView.canSeeLabel.bottomAnchor, constant: 30),
            findFriendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let listCollectionViewConstraints = [
            listCollectionView.topAnchor.constraint(equalTo: fruitListView.bottomAnchor, constant: 20),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        [titleLabelConstraints, fruitListViewConstraints, fruitEmptyViewConstraints, findFriendLabelConstraints, listCollectionViewConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
        
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recommendFruits == nil { return 0 }
        return recommendFruits!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCollectionViewCell.identifier, for: indexPath) as? FarmCollectionViewCell else {
            assert(false, "Wrong Cell")
        }
        
        cell.peoplePickLabel.text = "\(recommendFruits![indexPath.item].recommendUser!) 외 \(recommendFruits![indexPath.item].recommendCount)명 Pick!"
        cell.fruitLabel.text = recommendFruits![indexPath.item].recommendFruit!.fruitName
        cell.farmLabel.text = recommendFruits![indexPath.item].recommendFruit!.farmName
        cell.fruitInfoLabel.text = recommendFruits![indexPath.item].comment
        let fruitCategory = recommendFruits![indexPath.item].recommendFruit!.fruitCategory
        cell.fruitImageView.image = UIImage(named: FruitCategory.images[Int(fruitCategory)!])
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()
        detailViewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
