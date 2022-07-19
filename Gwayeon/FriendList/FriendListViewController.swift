//
//  FriendListViewController.swift
//  Gwayeon
//
//  Created by Kimhwiwon on 2022/07/19.
//

import UIKit

class FriendListViewController: UIViewController {
    
    var tableView: UITableView!
    
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
        FriendData(name: "닐", fruit: "orange", friendsCount: 28)
    ]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    func setupTableView() {
        let frame = self.view.frame
        
        tableView = UITableView(frame: frame, style: UITableView.Style(rawValue: 0)!)
        self.view.addSubview(tableView)
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
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
        cell.friendLabel.text = String(friendsList[indexPath.row].friendsCount)
        
        return cell
    }
    
}



