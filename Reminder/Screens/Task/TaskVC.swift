//
//  TaskVC.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 18.05.2025.
//

import UIKit
import SnapKit

protocol TaskOutputProtocol: AnyObject {
    func didAddReminder(_ reminder: Reminder)
}

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
    private let homeVM: HomeVM = .init()
    var dismissCallback: (() -> Void)?

    weak var delegate: TaskOutputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white.withAlphaComponent(0.90)
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        setupAddReminderView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleBackgroundTap))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }

    private func setupAddReminderView() {
        addReminderView.backgroundColor = .white
        addReminderView.layer.borderWidth = 1
        addReminderView.layer.cornerRadius = 8
        view.addSubview(addReminderView)
        addReminderView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalToSuperview().multipliedBy(0.4)
        }

        titleLabel.text = "New Task"
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        titleLabel.textAlignment = .left
        addReminderView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        remindTitleLabel.text = "Remind"
        remindTitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        addReminderView.addSubview(remindTitleLabel)
        remindTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        let dateStack = UIStackView(arrangedSubviews: [datePickerLogo, datePicker])
        dateStack.axis = .horizontal
        dateStack.spacing = 8
        dateStack.alignment = .center
        view.addSubview(dateStack)
        dateStack.snp.makeConstraints { make in
            make.top.equalTo(remindTitleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }

        datePickerLogo.image = UIImage(systemName: "calendar")
        datePickerLogo.tintColor = .black
        addReminderView.addSubview(datePickerLogo)
        datePickerLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
            make.top.equalTo(dateStack.snp.bottom).offset(4)
        }

        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        addReminderView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom)
            make.leading.equalTo(datePickerLogo.snp.trailing).offset(8)
        }

        let timeStack = UIStackView(arrangedSubviews: [timePickerLogo, timePicker])
        timeStack.axis = .horizontal
        timeStack.spacing = 8
        timeStack.alignment = .center
        view.addSubview(timeStack)
        timeStack.snp.makeConstraints { make in
            make.top.equalTo(dateStack.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(16)
        }

        timePickerLogo.image = UIImage(systemName: "clock")
        timePickerLogo.tintColor = .black
        addReminderView.addSubview(timePickerLogo)
        timePickerLogo.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(24)
            make.top.equalTo(timeStack.snp.bottom).offset(4)
        }

        timePicker.datePickerMode = .time
        timePicker.backgroundColor = .white
        addReminderView.addSubview(timePicker)
        timePicker.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom)
            make.leading.equalTo(timePickerLogo.snp.trailing).offset(8)
        }

        textField.placeholder = "Here will be the text of the new task."
        textField.backgroundColor = .white
        addReminderView.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalTo(timeStack.snp.bottom).offset(44)
            make.leading.trailing.equalToSuperview().inset(16)
        }

        addButton.addTarget(self, action: #selector(handleAddReminder), for: .touchUpInside)
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

    @objc private func handleAddReminder() {
        let newReminder = Reminder(
            id: UUID(),
            title: textField.text ?? "",
            time: timePicker.date,
            day: datePicker.date,
            checked: false
        )
        homeVM.reminders.append(newReminder)
        delegate?.didAddReminder(newReminder)
        dismiss(animated: true) {
            self.dismissCallback?()
        }
    }

    @objc private func handleBackgroundTap(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: view)
        if !addReminderView.frame.contains(location) {
            dismiss(animated: true) {
                self.dismissCallback?()
            }
        }
    }
}

#Preview {
    TaskVC()
}
