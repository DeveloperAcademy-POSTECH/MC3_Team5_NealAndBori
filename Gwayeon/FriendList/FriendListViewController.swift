//
//  FriendListViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

class FriendListViewController: UIViewController {
    
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
    
//    var tableTitle : UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 14, weight: .medium)
//        label.textColor = UIColor(red: 76/256, green: 76/256, blue: 76/256, alpha: 1.00)
//        label.text = "과연을 이용 중인 친구들"
//
//        return label
//    }()
    
    var tableView : UITableView = {
        let frame = UIScreen.main.bounds
        let tableView = UITableView(frame: frame, style: UITableView.Style(rawValue: 0)!)
        
        tableView.separatorInset = UIEdgeInsets.zero
        
        let separatorHeight = 1 / UIScreen.main.scale
        let separatorFrame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: separatorHeight)
        let line = UIView(frame: separatorFrame)
        tableView.tableHeaderView = line
        line.backgroundColor = tableView.separatorColor
        
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFriendListView()
    }
    
    func setupFriendListView() {
        
//        self.view.addSubview(tableTitle)
        self.view.addSubview(tableView)
        
        // table view layout
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        // table view data
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(FriendListViewCell.self, forCellReuseIdentifier: FriendListViewCell.cellId)
        
    }
    
}

extension FriendListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: FriendListViewCell.cellId,
                                                 for: indexPath) as! FriendListViewCell
        
        cell.nameLabel.text = friendsList[indexPath.row].name
        cell.fruitImage.image = UIImage(named: "apple")
        cell.friendNumberLabel.text = String(friendsList[indexPath.row].friendsCount)
        
        return cell
    }
    
}
