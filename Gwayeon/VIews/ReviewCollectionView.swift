//
//  ReviewListView.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/21.
//

import UIKit

class ReviewCollectionView: UIView {
    
    //    private struct ReviewData {
    //        var date: String
    //        var contents: String
    //        var authors: String
    //    }
    //
    //    private var reviewData = [
    //        ReviewData(date: "22.07.21", contents: "세상 존맛탱. 이 세상 복숭아가 아니다. 과즙 팡팡이에요. 사장님도 정말 친절하시구요. 저만 먹기 너무 아까워서 모두에게 알려요.", authors: "쏘니"),
    //        ReviewData(date: "22.07.01", contents: "너무 맛있어요 짱짱 추천!", authors: "에이든"),
    //        ReviewData(date: "22.06.29", contents: "모두가 눈물 흘리며 먹을 복숭아맛. 여기가 바로 무릉도원!", authors: "메리"),
    //        ReviewData(date: "22.06.17", contents: "물복계의 성지입니다.", authors: "제리")
    //    ]
    
    private var date = ["22.07.21", "22.07.01", "22.06.29", "22.06.17"]
    private var contents = ["세상 존맛탱. 이 세상 복숭아가 아니다. 과즙 팡팡이에요. 사장님도 정말 친절하시구요. 저만 먹기 너무 아까워서 모두에게 알려요.", "너무 맛있어요 짱짱 추천!", "모두가 눈물 흘리며 먹을 복숭아맛. 여기가 바로 무릉도원!", "물복계의 성지입니다."]
    private var authors = ["쏘니", "에이든", "메리", "제리"]
    
    private enum Size {
        static let collectionHorizontalSpacing: CGFloat = 16.0
        static let collectionVerticalSpacing: CGFloat = 24.0
        static let cellWidth: CGFloat = 280
        static let cellHeight: CGFloat = 264
        static let collectionInset = UIEdgeInsets(top: collectionVerticalSpacing,
                                                  left: collectionHorizontalSpacing,
                                                  bottom: 100,
                                                  right: collectionHorizontalSpacing)
    }
    
    // MARK: Properties
    private let collectionViewFlowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.sectionInset = Size.collectionInset
        flowLayout.estimatedItemSize = CGSize(width: Size.cellWidth, height: Size.cellHeight)
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
            listCollectionView.topAnchor.constraint(equalTo: self.topAnchor),
            listCollectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            listCollectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            listCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ]
        NSLayoutConstraint.activate(listCollectionViewConstraints)
    }
}

extension ReviewCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return date.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCollectionViewCell.cellIdentifier, for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
        
        cell.backgroundColor = .systemGray6
        cell.dateLabel.text = date[indexPath.item]
        cell.contentLabel.text = contents[indexPath.item]
        cell.authorLabel.text = authors[indexPath.item]
        return cell
    }
}
