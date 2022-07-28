//
//  TestViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/27.
//

import UIKit

class TestViewController: UIViewController {
    
    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Test Page"
        lbl.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseManager.shared.getUserInformation(uid: "1234") { results in
            switch results {
            case .success(let users):
                print(users)
            case .failure(let error):
                print(error)
            }
        }
        setTextLabel()
    }
    
    private func setTextLabel() {
        view.addSubview(textLabel)
        view.backgroundColor = .white
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let textLabelConstraints = [
            textLabel.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            textLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            textLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            textLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30)
        ]
        NSLayoutConstraint.activate(textLabelConstraints)
    }
    
}
