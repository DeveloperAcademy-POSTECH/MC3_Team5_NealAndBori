//
//  RecommendFarmViewController.swift
//  Gwayeon
//
//  Created by 이윤영 on 2022/07/20.
//

import UIKit

class RecommendFarmViewController: UIViewController {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "농장 추천하기"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        return titleLabel
    }()
    private lazy var categorySection = InputSection(frame: .zero, style: .fruitCategory)
    private lazy var varietySection = InputSection(frame: .zero, style: .fruitVariety)
    private lazy var farmNameSection = InputSection(frame: .zero, style: .farmName)
    private lazy var farmNumberSection = InputSection(frame: .zero, style: .farmNumber)
    private lazy var recommendationSection = InputSection(frame: .zero, style: .recommendation)
    private lazy var sectionStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 30
        stackView.alignment = .fill
        stackView.addArrangedSubviews(categorySection, varietySection, farmNameSection, farmNumberSection, recommendationSection)
        return stackView
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor(red: 246/255, green: 104/255, blue: 94/255, alpha: 1)
        button.layer.cornerRadius = 13
        button.isEnabled = false
        button.addTarget(nil, action: #selector(completeButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setGesture()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categorySection.becomeFirstResponder()
    }
    
    @objc private func completeButtonClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        
    }
    
    private func setLayout() {
        view.backgroundColor = .white
        view.addSubviews(titleLabel, sectionStackView, finishButton)
        
        let titleLabelConstraint = [
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ]
        let sectionStackViewConstraint = [
            sectionStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            sectionStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ]
        let finishButtonConstraint = [
            finishButton.heightAnchor.constraint(equalToConstant: 60),
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            finishButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ]
        [titleLabelConstraint, sectionStackViewConstraint, finishButtonConstraint].forEach { constraint in
            NSLayoutConstraint.activate(constraint)
        }
    }
    
    private func setGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapCategory))
        categorySection.addGestureRecognizer(tapGesture)
    }
    
    @objc private func didTapCategory() {
        let modalViewController = FruitSelectViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        modalViewController.getSelectedItem = { item in
            self.categorySection.setTextFieldItem(FruitCategory.names[item])
            modalViewController.dismiss(animated: true)
        }
        present(modalViewController, animated: true, completion: nil)
    }
}
