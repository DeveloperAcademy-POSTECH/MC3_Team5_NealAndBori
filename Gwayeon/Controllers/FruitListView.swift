//
//  FruitListView.swift
//  Gwayeon
//
//  Created by COBY_PRO on 2022/07/20.
//

import UIKit

final class FruitListView: UIView {
    
    private let data = ["전체", "사과", "자두", "수박", "복숭아", "참외", "포도"]
    
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
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(FruitCollectionViewCell.self,
                                forCellWithReuseIdentifier: FruitCollectionViewCell.identifier)
        return collectionView
    }()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCollectionViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setCollectionViewLayout() {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FruitCollectionViewCell.identifier, for: indexPath) as? FruitCollectionViewCell else {
            assert(false, "Wrong Cell")
        }
        
        if indexPath.item == 0 {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false , scrollPosition: .init())
        }
        
        cell.nameLabel.text = data[indexPath.item]
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FruitListView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
}
