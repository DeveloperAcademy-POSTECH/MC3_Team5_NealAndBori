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
        let label = UILabel()
        label.text = "대극천 복숭아"
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .mainColor
        return label
    }()
    
    private lazy var farmName: UILabel = {
        let label = UILabel()
        label.text = "오로라 농장"
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var recommandLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 한 마디"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    
    private let reviewListView = ReviewCollectionView()
    
    private lazy var callButton: UIButton = {
        var config = UIButton.Configuration.filled()
        config.cornerStyle = .medium
        config.baseBackgroundColor = .mainColor
        config.image = UIImage(systemName: "phone.fill")
        config.title = " 전화하기"
        config.attributedTitle?.font = .systemFont(ofSize: 20, weight: .bold)
        config.buttonSize = .large
        let button = UIButton(configuration: config)
        button.addTarget(self, action: #selector(callButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var modalButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("modal", for: .normal)
        button.addTarget(self, action: #selector(bottomSheetButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var phoneNumber = "01083770805"
    
    // MARK: Life Cycle Function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewComponent()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    // MARK: Configures
    
    @objc private func bottomSheetButtonTapped() {
        showMyViewControllerInACustomizedSheet()
    }
    
    func showMyViewControllerInACustomizedSheet() {
        let viewControllerToPresent = BottomSheetViewController()
        if let sheet = viewControllerToPresent.sheetPresentationController {
            sheet.detents = [.medium()]
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    @objc private func callButtonTapped() {
        guard let url = URL(string: "tel://\(phoneNumber)"),
              UIApplication.shared.canOpenURL(url) else {
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    private func configureViewComponent() {
        view.backgroundColor = .peachColor
        
        [fruitImageView, fruitName, farmName, reviewListView, recommandLabel, callButton, modalButton].forEach { component in
            view.addSubview(component)
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let fruitImageViewConstraints = [
            fruitImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32),
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let fruitNameConstraints = [
            fruitName.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 16),
            fruitName.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        let farmNameConstraints = [
            farmName.topAnchor.constraint(equalTo: fruitName.bottomAnchor, constant: 8),
            farmName.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
        ]
        
        let recommandLabelConstraints = [
            recommandLabel.topAnchor.constraint(equalTo: reviewListView.topAnchor, constant: 48),
            recommandLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
        ]
        
        let reviewListViewConstraints = [
            reviewListView.topAnchor.constraint(equalTo: farmName.bottomAnchor, constant: 48),
            reviewListView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            reviewListView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            reviewListView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ]
        
        let callButtonConstraints = [
            callButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -24),
            callButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            callButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            callButton.heightAnchor.constraint(equalToConstant: 56),
            callButton.widthAnchor.constraint(equalToConstant: view.frame.width * 0.65)
        ]
        
        let modalConstraints = [
            modalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            modalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]
        
        [fruitImageViewConstraints, fruitNameConstraints, farmNameConstraints, recommandLabelConstraints, reviewListViewConstraints, callButtonConstraints, modalConstraints].forEach { component in
            NSLayoutConstraint.activate(component)
        }
    }
}
