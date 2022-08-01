//
//  MyPageViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

enum CollectionViewCellSection: Int {
    case addingFarm = 0
}

class MyPageViewController: UIViewController {
    
    private let data = ["농장농장", "농장농장", "농장농장", "농장농장"]
    
    private var segmentButtonStatus: Bool = true
    
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
    
    private enum Section: Int {
        case first = 0
    }
    
    private let navigationTitleLabel: UILabel = { label in
        label.text = "나의 농장생활"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        return label
    }(UILabel())
    
    private let myProfileImageView: UIImageView = { imageView in
        imageView.image = UIImage(named: "peaches")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }(UIImageView())
    
    private let myNameLabel: UILabel = { label in
        label.text = "코비"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        return label
    }(UILabel())
    
    private let gwayeonCountLabel: UILabel = { label in
        let str = "100명의 과연이 있어요"
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributeString.setColor(color: .pointColor, forText: "100")
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.attributedText = attributeString
        return label
    }(UILabel())
    
    lazy private var gearButton: UIButton = { button in
        button.setImage(UIImage(systemName: "gearshape"), for: .normal)
        button.tintColor = .black
        return button
    }(UIButton())
    
    lazy private var disclosureButton: UIButton = { button in
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(disclosureButtonClicked(_:)), for: .touchUpInside)
        return button
    }(UIButton())
    
    lazy private var myRecommendationButton: UIButton = { button in
        button.setTitle("나의 추천 과일", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setButtonHighlight()
        // MARK: - closure에서 self를 쓰고자 한다면 lazy여야 한다.
        button.addTarget(self, action: #selector(segmentButtonClicked(_:)), for: .touchUpInside)
        return button
    }(UIButton())
    
    lazy private var purchaseListButton: UIButton = { button in
        button.setTitle("구매 리스트", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setButtonBlur()
        // MARK: - closure에서 self를 쓰고자 한다면 lazy여야 한다.
        button.addTarget(self, action: #selector(segmentButtonClicked(_:)), for: .touchUpInside)
        return button
    }(UIButton())
    
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
        collectionView.register(EmptyButtonCollectionViewCell.self, forCellWithReuseIdentifier: EmptyButtonCollectionViewCell.identifier)
        collectionView.register(MyPageFruitListCollectionViewCell.self, forCellWithReuseIdentifier: MyPageFruitListCollectionViewCell.identifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setMyStatusLayout()
        setSegmentControlLayout()
        setCollectionViewLayout()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        gearButton.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        gearButton.isHidden = false
    }
    
    @objc func disclosureButtonClicked(_ sender: Any) {
        let friendListViewController = FriendListViewController()
        friendListViewController.navigationItem.largeTitleDisplayMode = .never
        let backButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        backButtonItem.tintColor = .mainColor
        self.navigationItem.backBarButtonItem = backButtonItem
        self.navigationController?.pushViewController(friendListViewController, animated: true)
    }
    
    @objc func segmentButtonClicked(_ sender: Any) {
        if segmentButtonStatus {
            myRecommendationButton.setButtonBlur()
            purchaseListButton.setButtonHighlight()
        } else {
            myRecommendationButton.setButtonHighlight()
            purchaseListButton.setButtonBlur()
        }
        segmentButtonStatus.toggle()
        DispatchQueue.main.async { [weak self] in
            self?.listCollectionView.reloadData()
        }
    }
    
}

// MARK: Layout 설정함수
extension MyPageViewController {
    private func setNavigationTitle() {
        view.backgroundColor = .white
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "나의 농장 생활"
        self.navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 28, weight: .bold)]
        self.navigationItem.largeTitleDisplayMode = .always
        guard let navigationBar = self.navigationController?.navigationBar else { return }
        
        navigationBar.addSubview(gearButton)
        gearButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gearButton.trailingAnchor.constraint(equalTo: navigationBar.trailingAnchor, constant: -16), gearButton.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: -12), gearButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "뒤로", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .mainColor
        
    }
    
    private func setSegmentControlLayout() {
        [myRecommendationButton, purchaseListButton].forEach { button in
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let myRecommendationButtonConstraints = [
            myRecommendationButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            myRecommendationButton.topAnchor.constraint(equalTo: myProfileImageView.bottomAnchor, constant: 51),
            myRecommendationButton.widthAnchor.constraint(equalToConstant: 119),
            myRecommendationButton.heightAnchor.constraint(equalToConstant: 22)
        ]
        
        let purchaseListButtonConstraints = [
            purchaseListButton.leadingAnchor.constraint(equalTo: myRecommendationButton.trailingAnchor, constant: 16),
            purchaseListButton.topAnchor.constraint(equalTo: myRecommendationButton.topAnchor),
            purchaseListButton.widthAnchor.constraint(equalToConstant: 119),
            purchaseListButton.heightAnchor.constraint(equalToConstant: 22)
            
        ]
        
        [myRecommendationButtonConstraints, purchaseListButtonConstraints].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
    private func setMyStatusLayout() {
        [myProfileImageView, myNameLabel, gwayeonCountLabel, disclosureButton].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(component)
        }
        
        let myProfileImageViewConstraints = [
            myProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            myProfileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myProfileImageView.widthAnchor.constraint(equalToConstant: 68),
            myProfileImageView.heightAnchor.constraint(equalToConstant: 68)
        ]
        
        let myNameLabelConstraints = [
            myNameLabel.leadingAnchor.constraint(equalTo: myProfileImageView.trailingAnchor, constant: 16),
            myNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            myNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        ]
        
        let gwayeonCountLabelConstraints = [
            gwayeonCountLabel.leadingAnchor.constraint(equalTo: myNameLabel.leadingAnchor),
            gwayeonCountLabel.topAnchor.constraint(equalTo: myNameLabel.bottomAnchor, constant: 6),
            gwayeonCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ]
        
        let disclosureButtonConstraints = [
            disclosureButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            disclosureButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 35)
        ]
        
        [myProfileImageViewConstraints, myNameLabelConstraints, gwayeonCountLabelConstraints, disclosureButtonConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
        
    }
    
    private func setCollectionViewLayout() {
        view.addSubview(listCollectionView)
        listCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let listCollectionViewConstraints = [
            listCollectionView.topAnchor.constraint(equalTo: myRecommendationButton.bottomAnchor, constant: 20),
            listCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            listCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            listCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(listCollectionViewConstraints)
    }
}

// MARK: - CollectionView DataSource
extension MyPageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if segmentButtonStatus {
            switch indexPath.row {
            case Section.first.rawValue:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmptyButtonCollectionViewCell.identifier, for: indexPath) as? EmptyButtonCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.setParentViewController(viewController: self)
                return cell
                
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageFruitListCollectionViewCell.identifier, for: indexPath) as? MyPageFruitListCollectionViewCell else {
                    return UICollectionViewCell()
                }
                cell.setButtonOrLabelHidden(status: segmentButtonStatus)
                return cell
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyPageFruitListCollectionViewCell.identifier, for: indexPath) as? MyPageFruitListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.setParentViewController(viewController: self)
            cell.setButtonOrLabelHidden(status: segmentButtonStatus)
            return cell
        }
    }
}
// MARK: - CollectionView Delegate
extension MyPageViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if segmentButtonStatus {
            switch indexPath.row {
            case CollectionViewCellSection.addingFarm.rawValue:
                let recommendFarmViewController = RecommendFarmViewController()
                recommendFarmViewController.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.pushViewController(recommendFarmViewController, animated: true)
            default:
                let detailViewController = DetailViewController()
                detailViewController.navigationItem.largeTitleDisplayMode = .never
                self.navigationController?.pushViewController(detailViewController, animated: true)
            }
        }
    }
    
}
