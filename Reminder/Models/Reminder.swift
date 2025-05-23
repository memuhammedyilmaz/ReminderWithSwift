//
//  Reminder.swift
//  Reminder
//
//  Created by Muhammed Yılmaz on 16.05.2025.
//

import Foundation

struct Reminder: Codable {
    let id: UUID
    let title: String
    let time: Date
    let day : Date
    var checked: Bool
    var completedTime: String? 

    var description: String {
        return "Reminder(id: \(id), title: \(title), time: \(time), day: \(day), checked: \(checked))"
    }
}
