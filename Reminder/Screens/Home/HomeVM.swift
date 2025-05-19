//
//  HomeVM.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 12.05.2025.
//

import Foundation

protocol HomeInputProtocol: AnyObject {
    func addReminders()
}

class HomeVM {
    weak var outputDelegate: HomeOutputProtocol?
    weak var inputDelegate: HomeInputProtocol?
    
   
    
    init() {
        inputDelegate = self
    }
}

extension HomeVM: HomeInputProtocol {
    func addReminders() {
        let reminders = [
            Reminder(title: "Buy groceries", subtitle: "Milk, Bread, Eggs"),
            Reminder(title: "Doctor's appointment", subtitle: "10 AM at the clinic"),
            Reminder(title: "Meeting with John", subtitle: "Discuss project updates"),
            Reminder(title: "Buy groceries", subtitle: "Milk, Bread, Eggs"),
            Reminder(title: "Doctor's appointment", subtitle: "10 AM at the clinic"),
            Reminder(title: "Meeting with John", subtitle: "Discuss project updates"),
            Reminder(title: "Buy groceries", subtitle: "Milk, Bread, Eggs"),
            Reminder(title: "Doctor's appointment", subtitle: "10 AM at the clinic"),
            Reminder(title: "Meeting with John", subtitle: "Discuss project updates"),
            Reminder(title: "Buy groceries", subtitle: "Milk, Bread, Eggs"),
            Reminder(title: "Doctor's appointment", subtitle: "10 AM at the clinic"),
            Reminder(title: "Meeting with John", subtitle: "Discuss project updates"),
            Reminder(title: "Buy groceries", subtitle: "Milk, Bread, Eggs"),
            Reminder(title: "Doctor's appointment", subtitle: "10 AM at the clinic"),
            Reminder(title: "Meeting with John", subtitle: "Discuss project updates")]
        
        outputDelegate?.listReminders(reminders: reminders)
    }
    func checkReminder() {
    }
}



            
            
