//
//  ViewController.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 28.04.2025.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        // Navigation Bar
        let navigationBar = UINavigationBar()
        navigationBar.backgroundColor = .darkGray
        self.view.addSubview(navigationBar)
        navigationBar.translatesAutoresizingMaskIntoConstraints = false
        
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.equalToSuperview().offset(0)
            make.trailing.equalToSuperview().offset(0)
            make.height.equalTo(48)
        }
        
        // Label
        let label = UILabel()
        label.text = "Good Morning Muhammed"
        label.font = UIFont(name: "Inter-SemiBold", size: 28)
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(32)
        }
        
        // Icon
        let icon = UIImageView()
        icon.image = UIImage(systemName: "sunrise.fill")
        self.view.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        
        icon.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
            make.width.equalTo(40)
        }
        
        
        
        
    }
}





// MARK: - Preview
#Preview {
    let vc = ViewController()
    return vc
}

