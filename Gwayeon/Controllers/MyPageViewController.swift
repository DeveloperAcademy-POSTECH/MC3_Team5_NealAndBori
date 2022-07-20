//
//  MyPageViewController.swift
//  Gwayeon
//
//  Created by yudonlee on 2022/07/18.
//

import UIKit

class MyPageViewController: UIViewController {
    private let textLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "나의 농장생활"
        lbl.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        lbl.textAlignment = .center
        return lbl
    }()
    
    private let myProfileImageView: UIImageView = { imageView in
        imageView.image = UIImage(named: "peaches")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }(UIImageView())
    
    private let myNameLabel: UILabel = {
        $0.text = "코비"
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textAlignment = .left
        return $0
    }(UILabel())
    
    private let gwayeonCountLabel: UILabel = { lbl in
        let str = "100명의 과연이 있어요"
        let attributeString: NSMutableAttributedString = NSMutableAttributedString(string: str, attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])
        attributeString.setColor(color: .pointColor, forText: "100")
        lbl.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        lbl.attributedText = attributeString
        return lbl
    }(UILabel())
    
    private let disclosureButton: UIButton = { button in
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .black
        return button
    }(UIButton())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setMyStatusView()
    }
    
    private func setNavigationTitle() {
//        view.addSubview(textLabel)
        view.backgroundColor = .white
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: textLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"), style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.tintColor = .black
    }
    
    private func setMyStatusView() {
        [myProfileImageView, myNameLabel, gwayeonCountLabel, disclosureButton].forEach { component in
            view.addSubview(component)
        }
        
        myProfileImageView.translatesAutoresizingMaskIntoConstraints = false
        let myProfileImageViewConstraints = [
            myProfileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            myProfileImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            myProfileImageView.widthAnchor.constraint(equalToConstant: 68),
            myProfileImageView.heightAnchor.constraint(equalToConstant: 68)
        ]
        
        myNameLabel.translatesAutoresizingMaskIntoConstraints = false
        let myNameLabelConstraints = [
            myNameLabel.leadingAnchor.constraint(equalTo: myProfileImageView.trailingAnchor, constant: 16),
            myNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            myNameLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        ]
        
        gwayeonCountLabel.translatesAutoresizingMaskIntoConstraints = false
        let gwayeonCountLabelConstraints = [
            gwayeonCountLabel.leadingAnchor.constraint(equalTo: myNameLabel.leadingAnchor),
            gwayeonCountLabel.topAnchor.constraint(equalTo: myNameLabel.bottomAnchor, constant: 6),
            gwayeonCountLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -60)
        ]
        
        disclosureButton.translatesAutoresizingMaskIntoConstraints = false
        let disclosureButtonConstraints = [
            disclosureButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -26),
            disclosureButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 57)
        ]
        
        [myProfileImageViewConstraints, myNameLabelConstraints, gwayeonCountLabelConstraints, disclosureButtonConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    
    }
}
