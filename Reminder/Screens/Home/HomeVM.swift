//
//  HomeVM.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 12.05.2025.
//

import Foundation

protocol HomeInputProtocol: AnyObject {
    func reloadCollectionView()
}

class HomeVM {
    
    private let remindersKey = "remindersKey"
        var reminders: [Reminder] = [] {
            didSet {
                saveRemindersToUserDefaults()
            }
        }

        weak var inputDelegate: HomeInputProtocol?
        weak var outputDelegate: HomeOutputProtocol?

        init() {
            loadRemindersFromUserDefaults()
        }

        private func saveRemindersToUserDefaults() {
            if let data = try? JSONEncoder().encode(reminders) {
                UserDefaults.standard.set(data, forKey: remindersKey)
            }
        }

        private func loadRemindersFromUserDefaults() {
            if let data = UserDefaults.standard.data(forKey: remindersKey),
               let savedReminders = try? JSONDecoder().decode([Reminder].self, from: data) {
                reminders = savedReminders
            }
        }

        func toggleCheck(for id: UUID) {
            if let index = reminders.firstIndex(where: { $0.id == id }) {
                reminders[index].checked.toggle()
                saveRemindersToUserDefaults()
            }
        }
    func getGreetingMessage() -> String {
        let hour = Calendar.current.component(.hour, from: Date())
        switch hour {
        case 6..<12:
            return "Good Morning"
        case 12..<18:
            return "Good Afternoon"
        case 18..<22:
            return "Good Evening"
        default:
            return "Good Night"
        }
    }
}

extension HomeVM: HomeInputProtocol {
    func reloadCollectionView() {
        outputDelegate?.listReminders(reminders: reminders)
    }
}
