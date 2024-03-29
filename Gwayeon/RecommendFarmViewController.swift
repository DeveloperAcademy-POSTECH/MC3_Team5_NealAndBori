//
//  RecommendFarmViewController.swift
//  Gwayeon
//
//  Created by 이윤영 on 2022/07/20.
//

import UIKit

class RecommendFarmViewController: UIViewController {
    private var user: User?
    private var fruitCode: Int?
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "과일 추천하기"
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
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = UIColor.grey001
        button.layer.cornerRadius = 13
        button.isEnabled = false
        button.addTarget(nil, action: #selector(completeButtonClicked(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
        setGesture()
        setAction()
        fetchUserData()
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        categorySection.becomeFirstResponder()
    }
    
    @objc private func completeButtonClicked(_ sender: Any) {
        guard let user = user else { return }
        guard let fruitCode = fruitCode, let fruitName = varietySection.textField.text, let farmName = farmNameSection.textField.text, let farmNumber = farmNumberSection.textField.text, let comment = recommendationSection.textView.text else {
            return
        }
        let uid = user.uid
        let userName = user.userName
        // TODO: - Fruit와 FruitBaseInfo의 fruitCategory Int로 변경 후 수정
        let fruitBaseInfo = FruitBaseInfo(fruitCategory: String(describing: fruitCode), fruitName: fruitName, farmName: farmName, farmTelNumber: farmNumber)
        sendFruitData(uid: uid, userName: userName, fruitBaseInfo: fruitBaseInfo, comment: comment)
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
            finishButton.heightAnchor.constraint(equalToConstant: 55),
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
    
    private func setAction() {
        varietySection.endEditingAction = { self.checkInput() }
        varietySection.returnAction = { self.farmNameSection.textField.becomeFirstResponder() }

        farmNameSection.endEditingAction = { self.checkInput() }
        farmNameSection.returnAction = { self.farmNumberSection.textField.becomeFirstResponder() }

        farmNumberSection.startEditingAction = { self.categorySection.isHidden = true }
        farmNumberSection.endEditingAction = { self.farmNameSection.isHidden = false; self.checkInput() }
        farmNumberSection.returnAction = { self.recommendationSection.textView.becomeFirstResponder() }
        
        recommendationSection.startEditingAction = {
            self.categorySection.isHidden = true
            self.varietySection.isHidden = true
            self.farmNameSection.isHidden = true
        }
        recommendationSection.endEditingAction = {
            self.categorySection.isHidden = false
            self.varietySection.isHidden = false
            self.farmNameSection.isHidden = false
            self.checkInput()
        }
    }
    
    private func checkInput() {
        let checkCategory = categorySection.textField.placeholder != InputStyle.fruitCategory.placeholder
        let checkVariety = varietySection.textField.text != ""
        let checkFarmName = farmNameSection.textField.text != ""
        let checkFarmNumber = farmNumberSection.textField.text != "" && farmNumberSection.textField.text?.count ?? 0 >= 10
        let checkRecommendation = recommendationSection.textView.text != InputStyle.recommendation.placeholder
        
        if checkCategory && checkVariety && checkFarmName && checkFarmNumber && checkRecommendation {
            finishButton.isEnabled = true
            finishButton.backgroundColor = UIColor.mainRed
        } else {
            finishButton.isEnabled = false
            finishButton.backgroundColor = UIColor.grey001
        }
    }
    
    @objc private func didTapCategory() {
        let modalViewController = FruitSelectViewController()
        modalViewController.modalPresentationStyle = .pageSheet
        modalViewController.getSelectedItem = { item in
            self.categorySection.setTextFieldItem(FruitCategory.names[item])
            self.fruitCode = item
            modalViewController.dismiss(animated: true)
            self.varietySection.textField.becomeFirstResponder()
        }
        present(modalViewController, animated: true, completion: nil)
    }
    
    private func fetchUserData() {
        Task { [weak self] in
            self?.user = await FirebaseManager.shared.getUser()
        }
    }

    private func sendFruitData(uid: String, userName: String, fruitBaseInfo: FruitBaseInfo, comment: String) {
        FirebaseManager.shared.requestFruitInformation(uid: uid, fruitBaseInfo: fruitBaseInfo) { results in
            switch results {
            case .success(let fruitId):
                FirebaseManager.shared.requestRecommend(userId: uid, userName: userName, fruitId: fruitId, comment: comment)
            case .failure(let error):
                print(error)
                return
            }
        }
    }
}
