//
//  FruitSelectViewController.swift
//  Gwayeon
//
//  Created by 이윤영 on 2022/07/27.
//

import UIKit

class FruitSelectViewController: UIViewController {
    private let categoryArray = ["사과", "배", "귤", "수박", "포도", "복숭아", "토마토", "자두", "블루베리", "딸기", "참외", "멜론", "키위", "무화과", "망고", "감", "기타 과일"]
    private let categoryImage = ["apple", "pear", "tangerine", "watermelon", "grape", "peach-1", "tomato", "plum", "blueberry", "strawberry", "korean_melon", "melon", "kiwi", "fig", "mango", "persimmon", "other"]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "과일 선택"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let categoryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    var getSelectedItem: ((_ item: String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        setLayout()
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, categoryCollectionView)
        let titleLabelConstraint = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        let collectionViewConstraint = [
            categoryCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            categoryCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            categoryCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoryCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ]
        [titleLabelConstraint, collectionViewConstraint].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
    private func configureCollectionView() {
        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.register(FruitSelectCollectionViewCell.self, forCellWithReuseIdentifier: FruitSelectCollectionViewCell.identifier)
    }
}

extension FruitSelectViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 17
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellText = categoryArray[indexPath.item]
        let cellImage = categoryImage[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FruitSelectCollectionViewCell.identifier, for: indexPath) as? FruitSelectCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.label.text = cellText
        cell.fruitImage.image = UIImage(named: cellImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let collectionViewHeight = collectionView.bounds.height
        let cellWidth = (collectionViewWidth - 32 * 3)/4
        let cellHeight = (collectionViewHeight - 24 * 4)/5
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.getSelectedItem?(categoryArray[indexPath.item])
    }
}
