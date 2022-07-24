//
//  FriendListViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

// temporary data
struct FriendData {
    let name : String
    let fruit : String
    let friendsCount : Int
}

let friendsList = [
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

class FriendListViewController: UIViewController {
    
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
        
        // seperator edge 조정
        tableView.separatorInset = UIEdgeInsets.zero
        
        // table header
        let separatorHeight = 1 / UIScreen.main.scale
        let separatorFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: separatorHeight)
        let line = UIView(frame: separatorFrame)
        line.backgroundColor = tableView.separatorColor
        tableView.tableHeaderView = line
        
        // table footer
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 122)
        recommendTextLabel.frame = footerView.bounds
        recommendLinkLabel.frame = footerView.bounds
        footerView.addSubview(recommendTextLabel)
        footerView.addSubview(recommendLinkLabel)
        tableView.tableFooterView = footerView
        
        return tableView
    }()
    
    private let footerView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let recommendTextLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .medium)
        label.textColor = UIColor.black
        label.text = "찾으시는 친구가 없나요?"

        return label
    }()

    private let recommendLinkLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = UIColor(red: 255/256, green: 82/255, blue: 82/255, alpha: 1.00)
        label.text = "연락처에 있는 친구 과연으로 초대하기"

        return label
    }()
    
    private func setNavigationTitle() {
        self.navigationItem.title = "친구 리스트"
        
        let backButton = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = backButton
        
        self.navigationController?.navigationBar.tintColor = UIColor(red: 255/256, green: 82/255, blue: 82/255, alpha: 1.00)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationTitle()
        setupComponentLayout()
    }
    
    private func setupComponentLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableTitleLabel)
        self.view.addSubview(tableView)
        
        tableTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        recommendTextLabel.translatesAutoresizingMaskIntoConstraints = false
        recommendLinkLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
        
        // table footer layout
        let recommendTextLabelConstraints = [
            recommendTextLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 30),
            recommendTextLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]

        let recommendLinkLabelConstraints = [
            recommendLinkLabel.topAnchor.constraint(equalTo: recommendTextLabel.bottomAnchor, constant: 14),
            recommendLinkLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ]
        
        [tableTitleLabelConstraints, tableViewConstraints, recommendTextLabelConstraints, recommendLinkLabelConstraints].forEach { constraints in
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
        
        cell.setupData(rowNumber: indexPath.row)
        
        return cell
    }
    
}
