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
    var items = ["1", "2", "3", "4", "5", "6"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configures()
    }
    
    // MARK: Configures
    func configures() {
        collectionView.register(DetailCollectionCell.self, forCellWithReuseIdentifier: detailColletcionCellIdentifier)
    }
}

extension DetailCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: detailColletcionCellIdentifier, for: indexPath) as! DetailCollectionCell
        cell.item = items[indexPath.row]
        return cell
    }
}
