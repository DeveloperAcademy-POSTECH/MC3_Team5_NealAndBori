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
    
    private lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.backgroundColor = .white
        whiteView.layer.cornerRadius = 30
        return whiteView
    }()
    
    private let recommendLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 한마디"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
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
    
    private let reviewListView = ReviewListView()
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .vertical
            flowLayout.sectionInset = Size.collectionInset
            flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
            flowLayout.minimumLineSpacing = 16
            return flowLayout
        }()
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
    }
    
    // MARK: Configures
    private func configureViewComponent() {
        view.backgroundColor = .peachColor
        
        view.addSubview(fruitImageView)
        fruitImageView.translatesAutoresizingMaskIntoConstraints = false
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(fruitImageViewConstraints)
        
        view.addSubview(fruitName)
        fruitName.translatesAutoresizingMaskIntoConstraints = false
        let fruitNameConstraints = [
            fruitName.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 24),
            fruitName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(fruitNameConstraints)
        
        view.addSubview(farmName)
        farmName.translatesAutoresizingMaskIntoConstraints = false
        let farmNameConstraints = [
            farmName.topAnchor.constraint(equalTo: fruitName.bottomAnchor, constant: 8),
            farmName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        NSLayoutConstraint.activate(farmNameConstraints)
        
        view.addSubview(whiteView)
        whiteView.translatesAutoresizingMaskIntoConstraints = false
        let whiteViewConstraints = [
            whiteView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            whiteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            whiteView.heightAnchor.constraint(equalToConstant: view.frame.height * 0.58),
            whiteView.widthAnchor.constraint(equalToConstant: view.frame.width)
        ]
        NSLayoutConstraint.activate(whiteViewConstraints)
        
        view.addSubview(recommendLabel)
        recommendLabel.translatesAutoresizingMaskIntoConstraints = false
        let recommendLabelConstraints = [
            recommendLabel.topAnchor.constraint(equalTo: whiteView.topAnchor, constant: 48),
            recommendLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        NSLayoutConstraint.activate(recommendLabelConstraints)
        
        view.addSubview(reviewListView)
        reviewListView.translatesAutoresizingMaskIntoConstraints = false
        let reviewListViewConstraints = [
            reviewListView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            reviewListView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        NSLayoutConstraint.activate(reviewListViewConstraints)
    }
}

// MARK: - UICollectionViewDataSource
//extension DetailViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return data.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FarmCollectionViewCell.cellId, for: indexPath) as? FarmCollectionViewCell else {
//            assert(false, "Wrong Cell")
//        }
//
//        return dequeuedCell
//    }
//}
