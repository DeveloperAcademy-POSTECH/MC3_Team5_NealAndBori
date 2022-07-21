//
//  FriendListViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

class FriendListViewController: UIViewController {
    
    // temporary data
    private struct FriendData {
        let name : String
        let fruit : String
        let friendsCount : Int
    }
    
    private let friendsList = [
        FriendData(name: "메리", fruit: "apple", friendsCount: 10),
        FriendData(name: "소니", fruit: "pear", friendsCount: 33),
        FriendData(name: "제리", fruit: "grape", friendsCount: 22),
        FriendData(name: "에이든", fruit: "strawberry", friendsCount: 55),
        FriendData(name: "코비", fruit: "persimmon", friendsCount: 111),
        FriendData(name: "닐", fruit: "orange", friendsCount: 28),
        FriendData(name: "메리", fruit: "apple", friendsCount: 10),
        FriendData(name: "소니", fruit: "pear", friendsCount: 33),
        FriendData(name: "제리", fruit: "grape", friendsCount: 22),
        FriendData(name: "에이든", fruit: "strawberry", friendsCount: 55),
        FriendData(name: "코비", fruit: "persimmon", friendsCount: 111),
        FriendData(name: "닐", fruit: "orange", friendsCount: 28)
    ]
    
    private let tableTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 76/256, green: 76/256, blue: 76/256, alpha: 1.00)
        label.text = "과연을 이용 중인 친구들"

        return label
    }()
        
    private lazy var tableView : UITableView = {
        let frame = UIScreen.main.bounds
        let tableView = UITableView(frame: frame, style: .plain)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FriendListViewCell.self, forCellReuseIdentifier: FriendListViewCell.cellId)
        
        tableView.separatorInset = UIEdgeInsets.zero
        let separatorHeight = 1 / UIScreen.main.scale
        let separatorFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: separatorHeight)
        let line = UIView(frame: separatorFrame)
        line.backgroundColor = tableView.separatorColor
        tableView.tableHeaderView = line
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 122))
        
        let label = UILabel(frame: footerView.bounds)
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = UIColor.black
        label.text = "찾으시는 친구가 없나요?"
        let label2 = UILabel(frame: footerView.bounds)
        label2.font = .systemFont(ofSize: 17, weight: .light)
        label2.textColor = UIColor(red: 255/256, green: 82/255, blue: 82/255, alpha: 1.00)
        label2.text = "연락처에 있는 친구 과연으로 초대하기"
        
        footerView.addSubview(label)
        footerView.addSubview(label2)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label2.translatesAutoresizingMaskIntoConstraints = false
        
        label.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 30).isActive = true
        label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        label2.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 14).isActive = true
        label2.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20).isActive = true
        
        tableView.tableFooterView = footerView
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupComponentLayout()
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableTitleLabel)
        self.view.addSubview(tableView)
        
        tableTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        // table title layout
        let tableTitleLabelConstraints = [
            tableTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            tableTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        // table view layout
        let tableViewConstraints = [
            tableView.topAnchor.constraint(equalTo: tableTitleLabel.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]

        [tableTitleLabelConstraints, tableViewConstraints].forEach { constraints in
            NSLayoutConstraint.activate(constraints)
        }
    }
    
}

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendListViewCell.cellId,
                                                           for: indexPath) as? FriendListViewCell else { return UITableViewCell() }
        
        cell.nameLabel.text = friendsList[indexPath.row].name
        cell.fruitImage.image = UIImage(named: "apple")
        cell.friendNumberLabel.text = String(friendsList[indexPath.row].friendsCount)
        
        return cell
    }
    
}
