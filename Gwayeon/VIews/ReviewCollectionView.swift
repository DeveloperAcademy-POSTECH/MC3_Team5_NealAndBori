//
//  ReviewListView.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/21.
//

import UIKit

class ReviewCollectionView: UIView {
    
    private let data = ["사과", "자두", "수박", "복숭아"]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 16.0
        static let collectionVerticalSpacing: CGFloat = 24.0
        static let cellWidth: CGFloat = 280
        static let cellHeight: CGFloat = 264
        static let collectionInset = UIEdgeInsets(top: collectionVerticalSpacing,
                                                  left: collectionHorizontalSpacing,
                                                  bottom: collectionVerticalSpacing,
                                                  right: collectionHorizontalSpacing)
    }
    
    // MARK: Properties
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Size.collectionInset
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 16
        return flowLayout
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .white
        collectionView.layer.cornerRadius = 12
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(ReviewCollectionViewCell.self,
                                forCellWithReuseIdentifier: ReviewCollectionViewCell.cellIdentifier)
        return collectionView
    }()
    
    // MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCollectionViewLayout() {
        self.addSubview(listCollectionView)
        
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let listCollectionViewConstraints = [
            listCollectionView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            listCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            listCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            listCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(listCollectionViewConstraints)
    }
}

extension ReviewCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.cellIdentifier, for: indexPath) as? ReviewCollectionViewCell else {
            assert(false, "Wrong Cell")
        }
        cell.backgroundColor = .systemGray6
        //        dequeuedCell.nameLabel.text = data[indexPath.item]
        return cell
    }
}
