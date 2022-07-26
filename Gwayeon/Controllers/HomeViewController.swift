//
//  HomeViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

class HomeViewController: UIViewController {
    
//    private let data = ["농장농장", "농장농장", "농장농장", "농장농장"]
    private let data = [String]()
    
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
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(FarmCollectionViewCell.self,
                                forCellWithReuseIdentifier: FarmCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
    }
    
    // MARK: Configures
    private func configureViewComponent() {
        view.backgroundColor = .white
        if !data.isEmpty {
            fruitEmptyView.isHidden = true
        }
        
        [titleLabel, fruitListView, fruitEmptyView, listCollectionView].forEach { component in
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
            fruitEmptyView.topAnchor.constraint(equalTo: fruitListView.bottomAnchor, constant: 40),
            fruitEmptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            fruitEmptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            fruitEmptyView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        let listCollectionViewConstraints = [
            listCollectionView.topAnchor.constraint(equalTo: fruitListView.bottomAnchor, constant: 20),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        [titleLabelConstraints, fruitListViewConstraints, fruitEmptyViewConstraints, listCollectionViewConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCollectionViewCell.identifier, for: indexPath) as? FarmCollectionViewCell else {
            assert(false, "Wrong Cell")
        }
        
        return dequeuedCell
    }
}

