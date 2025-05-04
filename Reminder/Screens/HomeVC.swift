//
//  ViewController.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 28.04.2025.
//

import UIKit
import SnapKit

class HomeVC: UIViewController {
    
    let navigationBar = UINavigationBar()
    let nameLabel = UILabel()
    let calendarIcon = UIImageView()
    let tableView = UITableView()
    let headerView = UIView()
    let headerLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.separatorStyle = .none
        
        tableView.register(CellVC.self, forCellReuseIdentifier: "CustomCell")
        
        self.view.addSubview(headerView)
        
        // Navigation Bar
        navigationBar.backgroundColor = .darkGray
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        // NameLabel
        nameLabel.text = "Good Morning Yusuf"
        nameLabel.font = UIFont(name: "Inter-SemiBold", size: 28) ?? UIFont.systemFont(ofSize: 28, weight: .semibold)
        self.view.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // CalendarIcon
        calendarIcon.image = UIImage(systemName: "calendar")
        calendarIcon.tintColor = .black
        self.view.addSubview(calendarIcon)
        calendarIcon.translatesAutoresizingMaskIntoConstraints = false
        
        // Add a label to the header view
        headerLabel.text = "Today's Reminders"
        headerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        headerLabel.font = UIFont(name: "SF-Pro-SemiBold", size: 15) ?? UIFont.systemFont(ofSize: 15, weight: .light)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        
        // TableView
        tableView.backgroundColor = .white
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        
        
        // CONTRAINTS
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(48)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(32)
        }
        
        calendarIcon.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
            make.leading.equalToSuperview().offset(336)
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16) // Position below headerView
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 16, bottom: 16, right: 16))
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(16) // Position below nameLabel
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48) // Adjust height to fit content
        }
    }
}


extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as? CellVC else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.titleLabel.text = "Reminder \(indexPath.row + 1)"
        return cell
    }
}

class CellVC: UITableViewCell {
    
    let containerView = UIView()
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Container View
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
            make.height.equalTo(60)
        }
        
        
        // Title Label
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-16)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



// MARK: - Preview
#Preview {
    HomeVC()
}

