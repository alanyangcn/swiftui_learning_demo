//
//  TaskViewModel.swift
//  TaskManagement (iOS)
//
//  Created by 杨立鹏 on 2022/1/13.
//

import SwiftUI

class TaskViewModel: ObservableObject {
    @Published var storedTasks: [Task] = [
        Task(taskTitle: "Meeting", taskDescription: "Discuss team task for the day", taskDate: .init(timeIntervalSince1970: 1642038120)),
        Task(taskTitle: "Icon Set", taskDescription: "Edit icons fo team task for next week", taskDate: .init(timeIntervalSince1970: 1642039582)),
        Task(taskTitle: "Prototype", taskDescription: "Make and send prototype", taskDate: .init(timeIntervalSince1970: 1642042697)),
        Task(taskTitle: "Check asset", taskDescription: "Start checking the assets", taskDate: .init(timeIntervalSince1970: 1642056297)),
        Task(taskTitle: "Team Party", taskDescription: "Make fun with team mates", taskDate: .init(timeIntervalSince1970: 1642061897)),
        Task(taskTitle: "Client Meeting", taskDescription: "Explain project to client", taskDate: .init(timeIntervalSince1970: 1642041897)),
        Task(taskTitle: "Next Project", taskDescription: "Discuss next project with team", taskDate: .init(timeIntervalSince1970: 1642077897)),
        Task(taskTitle: "App Proposal", taskDescription: "Meet client for next app Proposal", taskDate: .init(timeIntervalSince1970: 1642081497)),
    ]

    @Published var currentWeek: [Date] = []

    @Published var currentDate: Date = Date()
    
    @Published var filteredTasks: [Task]?

    init() {
        fetchCurrentWeek()
        filterTodayTasks()
    }
    
    func filterTodayTasks() {
        DispatchQueue.global(qos: .userInitiated).async {
            let filtered = self.storedTasks.filter({Calendar.current.isDate($0.taskDate, inSameDayAs: self.currentDate)}).sorted(by: {$0.taskDate > $1.taskDate})
            
            DispatchQueue.main.async {
                withAnimation {
                    self.filteredTasks = filtered
                }
            }
        }
    }

    func fetchCurrentWeek() {
        let today = Date()
        let calender = Calendar.current

        let week = calender.dateInterval(of: .weekOfMonth, for: today)

        guard let firstWeekDay = week?.start else { return }

        (1 ... 7).forEach { day in
            if let weekday = calender.date(byAdding: .day, value: day, to: firstWeekDay) {
                currentWeek.append(weekday)
            }
        }
    }

    func extractDate(date: Date, format: String) -> String {
        let formatter = DateFormatter()

        formatter.dateFormat = format

        return formatter.string(from: date)
    }

    func isToday(date: Date) -> Bool {
        Calendar.current.isDate(currentDate, inSameDayAs: date)
    }
    
    func isCurrentHour(date: Date) -> Bool {
        let calender = Calendar.current
        
        let hour = calender.component(.hour, from: date)
        let currentHour = calender.component(.hour, from: Date())
        
        return hour == currentHour
    }
}
