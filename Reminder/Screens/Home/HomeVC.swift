//
//  ViewController.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 28.04.2025.
//

import UIKit
import SnapKit

protocol HomeOutputProtocol: AnyObject {
    func listReminders(reminders: [Reminder])
}


class HomeVC: UIViewController, TaskOutputProtocol {
    
    func didAddReminder(_ reminder: Reminder) {
           homeVM.reminders.append(reminder)
           listReminders(reminders: homeVM.reminders)
    }
    
    private let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    private let homeVM: HomeVM = .init()
    
    var reminderArray: [Reminder] = []
    
    
    let navigationBar = UINavigationBar()
    let nameLabel = UILabel()
    let calendarIcon = UIImageView()
    let collectionView: UICollectionView
    let headerView = UIView()
    let headerLabel = UILabel()
    let addButton = UIButton()
    let daysSliderView = DaysVC()
    
    var dateTimeString: String = "Good Morning"
    var name: String = "Muhammed"
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: coder)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.reloadData()
        homeVM.reloadCollectionView()
        dateTimeString = homeVM.getGreetingMessage()
        homeVM.outputDelegate = self
        
        listReminders(reminders: homeVM.reminders)
        
        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        
        
        // Navigation Bar
        navigationBar.backgroundColor = .clear
        self.view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(48)
        }
        
        // Add DaysSliderView
        navigationBar.addSubview(daysSliderView)
        daysSliderView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // Name Label
        nameLabel.text = "\(dateTimeString) \(name)"
        nameLabel.font = UIFont(name: "Inter-SemiBold", size: 20) ?? UIFont.systemFont(ofSize: 20, weight: .semibold)
        self.view.addSubview(nameLabel)
        
        // Calendar Icon
        calendarIcon.image = UIImage(systemName: "calendar")
        calendarIcon.tintColor = .black
        self.view.addSubview(calendarIcon)
        calendarIcon.snp.makeConstraints { make in
            make.width.equalTo(36)
            make.height.equalTo(48)
        }
        
        // Stack View
        let nameStack = UIStackView(arrangedSubviews: [nameLabel, calendarIcon])
        nameStack.axis = .horizontal
        nameStack.spacing = 8
        nameStack.alignment = .center
        self.view.addSubview(nameStack)
        nameStack.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(34)
        }
        
        // Header View
        headerLabel.text = "Today's Reminders"
        headerLabel.font = UIFont(name: "SF-Pro-SemiBold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .light)
        headerLabel.textColor = .black
        headerLabel.textAlignment = .center
        headerView.addSubview(headerLabel)
        self.view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.equalTo(nameStack.snp.bottom).offset(8)
            make.leading.equalTo(32)
            make.height.equalTo(24)
        }
        headerLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0))
        }
        
        // Collection View
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CellVC.self, forCellWithReuseIdentifier: "ReminderCell")
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(16)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        // Add Button
        
        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 40, weight: .bold)), for: .normal)
        addButton.tintColor = .white
        addButton.backgroundColor = .black
        addButton.layer.cornerRadius = 32
        self.view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.width.equalTo(64)
            make.height.equalTo(64)
            make.trailing.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(32)
        }
    }
    
    @objc private func addButtonTapped() {
            let taskVC = TaskVC()
            taskVC.delegate = self
            taskVC.modalPresentationStyle = .overCurrentContext
            present(taskVC, animated: true, completion: nil)
        }

}

extension HomeVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //homeVM.reminders.count
        return reminderArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReminderCell", for: indexPath) as? CellVC else {
            return UICollectionViewCell()
        }
        let reminder = reminderArray[indexPath.row]
        let title = reminder.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let timeString = dateFormatter.string(from: reminder.time)
        let subtitle = "Created at: \(timeString)"
        let isChecked = reminder.checked

        
        cell.configure(id: reminder.id, title: title, subtitle: subtitle, isChecked: isChecked)
        cell.onReminderTapped = { [weak self] id in
            guard let self = self else { return }
            if let index = self.reminderArray.firstIndex(where: { $0.id == id }) {
                self.reminderArray[index].checked.toggle()
                collectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 60)
    }
}

extension HomeVC: HomeOutputProtocol {
    func listReminders(reminders: [Reminder]) {
        self.reminderArray = reminders
        print("Reminders: \(reminderArray)")
        collectionView.reloadData()
    }
   
}


#Preview {
    HomeVC()
}
