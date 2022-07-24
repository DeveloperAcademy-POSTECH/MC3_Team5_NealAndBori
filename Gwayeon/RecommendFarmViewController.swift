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
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        // TODO: addArrangedSubviews Extension으로 작성
        stackView.addArrangedSubview(categorySection)
        stackView.addArrangedSubview(varietySection)
        stackView.addArrangedSubview(farmNameSection)
        stackView.addArrangedSubview(farmNumberSection)
        stackView.addArrangedSubview(recommendationSection)
        
        return stackView
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor(red: 246/255, green: 104/255, blue: 94/255, alpha: 1)
        button.layer.cornerRadius = 13
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categorySection.becomeFirstResponder()
    }
    
    // TODO: 함수명 통일
    private func configureLayout() {
        // TODO: addSubviews Extension으로 작성
        view.addSubview(titleLabel)
        view.addSubview(sectionStackView)
        view.addSubview(finishButton)
        view.backgroundColor = .white
        
        // TODO: 팀원과 상의 후 코드 스타일 변경
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16)
        ])
        NSLayoutConstraint.activate([
            sectionStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            sectionStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            sectionStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
        NSLayoutConstraint.activate([
            finishButton.heightAnchor.constraint(equalToConstant: 60),
            finishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            finishButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            finishButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])
    }
}

// TODO: Extension 폴더 분리
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}