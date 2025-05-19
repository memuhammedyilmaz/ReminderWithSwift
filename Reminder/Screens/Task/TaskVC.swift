//
//  TaskVC.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 18.05.2025.
//

import UIKit
import SnapKit

import UIKit
import SnapKit

class TaskVC: UIViewController {
    
    private let addReminderView = UIView()
    private let titleLabel = UILabel()
    private let addButton = UIButton()
    private let remindTitleLabel = UILabel()
    private let datePicker = UIDatePicker()
    private let datePickerLogo = UIImageView()
    private let timePicker = UIDatePicker()
    private let timePickerLogo = UIImageView()
    private let textField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        
        setupAddReminderView()
    }
    
    private func setupAddReminderView() {
        // Container view
        addReminderView.backgroundColor = .clear
        addReminderView.layer.borderWidth = 1
        addReminderView.layer.cornerRadius = 8
        view.addSubview(addReminderView)
        
        addReminderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.4)
        }
        
        // Title label
        titleLabel.text = "New Task"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .left
        addReminderView.addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Remind title label
        remindTitleLabel.text = "Remind"
        remindTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addReminderView.addSubview(remindTitleLabel)
        
        remindTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }
        
        // Stack View
        let dateStack = UIStackView(arrangedSubviews: [datePickerLogo, datePicker])
        dateStack.axis = .horizontal
        dateStack.spacing = 8
        dateStack.alignment = .center
        self.view.addSubview(dateStack)
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(remindTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        // Date Picker Logo
        datePickerLogo.image = UIImage(systemName: "calendar")
        datePickerLogo.tintColor = .black
        addReminderView.addSubview(datePickerLogo)
        datePickerLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(dateStack.snp.bottom).offset(4)
        }
        
        // Date picker
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        addReminderView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(0)
            make.leading.equalTo(datePickerLogo.snp.trailing).offset(8)
        }
         
        // Stack View 2
        let timeStack = UIStackView(arrangedSubviews: [timePickerLogo, timePicker])
        timeStack.axis = .horizontal
        timeStack.spacing = 8
        timeStack.alignment = .center
        self.view.addSubview(timeStack)
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }
        
        // Time Logo
        timePickerLogo.image = UIImage(systemName: "clock")
        timePickerLogo.tintColor = .black
        addReminderView.addSubview(timePickerLogo)
        timePickerLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(24)
            make.height.equalTo(24)
            make.top.equalTo(timeStack.snp.bottom).offset(4)
        }
        
        // Time Picker
        timePicker.datePickerMode = .time
        timePicker.backgroundColor = .white
        addReminderView.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(0)
            make.leading.equalTo(timePickerLogo.snp.trailing).offset(8)
        }
        
        // TextField
        textField.placeholder = "Here will be the text of the new task."
        textField.backgroundColor = .white
        addReminderView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview().inset(16)
        }
            
        
        // Configure the add button
        addButton.setTitle("Save", for: .normal)
        addButton.backgroundColor = .black
        addButton.setTitleColor(.white, for: .normal)
        addButton.layer.cornerRadius = 8
        addReminderView.addSubview(addButton)
        
        addButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-16)
            make.trailing.equalToSuperview().inset(16)
            make.width.equalTo(64)
            make.height.equalTo(32)
        }
        
        
    }
    
}

#Preview {
    TaskVC()
}
