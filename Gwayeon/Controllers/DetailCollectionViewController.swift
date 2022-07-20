//
//  DetailCollectionCollectionViewController.swift
//  Gwayeon
//
//  Created by Ayden on 2022/07/20.
//

import UIKit

private let detailColletcionCellIdentifier = "cell"

class DetailCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
//    private struct recommendData {
//        let date: String
//        let recommendContents: String
//        let author: String
//    }
//
//    private var recommendDataList = [
//        recommendData(date: "22.07.21", recommendContents: "신선하고 과즙이 팡팡이에요! 배송이 정말 빠르고 사장님도 친절하세요. 물복파 모두 모여~!", author: "From.쏘니"),
//        recommendData(date: "22.07.09", recommendContents: "여기만큼 맛있는 복숭아를 못 찾았어요. 매년 시켜먹습니다.", author: "From.닐"),
//        recommendData(date: "22.07.08", recommendContents: "사장님의 복숭아를 향한 자신감만큼 보장하는 맛입니다. 20년동안 복숭아 농사하셨다고 하는데 퀄리티가 마트와는 차원이 달라요.", author: "From. 에이든")
//    ]
    
    let items = ["1", "2", "3", "4", "5","6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Collection view controller did load!")
        configures()
    }
    
    // MARK: Configures
    func configures() {
        collectionView.register(DetailCollectionCell.self, forCellWithReuseIdentifier: detailColletcionCellIdentifier)
    }
}

extension DetailCollectionViewController {
    // MARK: Cell Count
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    // MARK: Cell
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailColletcionCellIdentifier, for: indexPath) as! DetailCollectionCell
        cell.item = items[indexPath.row]
        return cell
    }
}

extension DetailCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.75, height: view.frame.height * 0.32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}
