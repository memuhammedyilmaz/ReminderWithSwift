//
//  SplashVC.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 18.05.2025.
//

import UIKit
import SnapKit

class SplashVC: UIViewController {
    
    private let SplashView = UIImageView()
    private let welcomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Welcome Label
        welcomeLabel.text = "Welcome Reminder"
        welcomeLabel.font = .systemFont(ofSize: 40, weight: .bold)
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(225)
            make.leading.equalToSuperview().inset(25)
        }
        
        
        // Reminder Logo
        SplashView.image = UIImage(systemName: "calendar")
        SplashView.tintColor = .black
        view.addSubview(SplashView)
        SplashView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview().inset(320)
            make.leading.trailing.equalToSuperview().inset(60)
        }
        
        // UserName TextFiled
    
        
    }
}

#Preview {
    SplashVC()
}
