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

class FriendListViewController: UIViewController {

    private var user: User? //사용자 정보
    
    private let tableTitleLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor.systemGray
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

    private lazy var recommendLinkLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .light)
        label.textColor = UIColor.mainColor
        label.text = "과연 추가하기"
        
        // label에 과연 추가 sheet 연결 위한 tap gesture 추가
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(tap)
        return label
    }()
    
    private func setNavigationTitle() {
        self.navigationItem.title = "친구 리스트"
    }
    
    // 현재 사용자 정보, 친구 정보 업데이트
    private func fetchData() {
        Task { [weak self] in
            self?.user = await FirebaseManager.shared.getUser()
            tableView.reloadData()
        }
    }
    
    // "과연 추가하기" 클릭 시 모달뷰 띄우기
    @objc private func tapFunction() {
        let viewController = FriendAddViewController()
        // FriendAdd 모달에서 친구 추가 시 FriendList View update 함수 실행
        viewController.addNewFriend = {
            self.fetchData()
        }
        // FriendAdd 모달에 navigation controller 추가
        let navigationController = UINavigationController(rootViewController: viewController)
        present(navigationController, animated: true, completion: nil)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData() // 현재 사용자 정보 가져오기, 테이블 업데이트
        setNavigationTitle()
        setLayout()
    }
    
    private func setLayout() {
        
        view.backgroundColor = .systemBackground
        
        self.view.addSubview(tableTitleLabel)
        self.view.addSubview(tableView)
        
        [tableTitleLabel, tableView, recommendTextLabel, recommendLinkLabel].forEach { component in
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        // table title layout
        let tableTitleLabelConstraints = [
            tableTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
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
        return user?.friends?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FriendListViewCell.cellId,
                                                           for: indexPath) as? FriendListViewCell else { return UITableViewCell() }
        
        guard let friendUid = user?.friends?[indexPath.row]
        else {
            return cell
        }
        
        FirebaseManager.shared.fetchUserInformation(uid: friendUid) { results in
            switch results {
            case .success(let friendData):
                let friendsNumber = friendData.friends?.count ?? 0
                cell.configure(userName : friendData.userName, userImageName : friendData.userImageName, friendsNumber : friendsNumber)
            case .failure(let error):
                return
            }
        }
        return cell
        
    }
}
