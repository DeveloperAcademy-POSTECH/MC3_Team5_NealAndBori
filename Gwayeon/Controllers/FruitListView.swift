//
//  FruitListView.swift
//  Gwayeon
//
//  Created by COBY_PRO on 2022/07/20.
//

import UIKit

final class FruitListView: UIView {
    
    private let data = ["사과", "자두", "수박", "복숭아"]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 16.0
        static let collectionVerticalSpacing: CGFloat = 0.0
        static let cellWidth: CGFloat = 90
        static let cellHeight: CGFloat = 45
        static let collectionInset = UIEdgeInsets(top: collectionVerticalSpacing,
                                                  left: collectionHorizontalSpacing,
                                                  bottom: collectionVerticalSpacing,
                                                  right: collectionHorizontalSpacing)
    }
    
    // MARK: - property
    
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Size.collectionInset
        flowLayout.itemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
        flowLayout.minimumLineSpacing = 8
        return flowLayout
    }()
    
    private lazy var listCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FruitCollectionViewCell.self,
                                forCellWithReuseIdentifier: FruitCollectionViewCell.cellId)
        return collectionView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func render() {
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

// MARK: - UICollectionViewDataSource
extension FruitListView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let dequeuedCell = collectionView.dequeueReusableCell(withReuseIdentifier: FruitCollectionViewCell.cellId, for: indexPath) as? FruitCollectionViewCell else {
            assert(false, "Wrong Cell")
        }
        
        dequeuedCell.nameLabel.text = data[indexPath.item]
        
        return dequeuedCell
    }
}
