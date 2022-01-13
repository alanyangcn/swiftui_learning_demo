//
//  Task.swift
//  TaskManagement (iOS)
//
//  Created by 杨立鹏 on 2022/1/13.
//

import SwiftUI

struct Task: Identifiable {
    
    var id = UUID().uuidString
    var taskTitle: String
    var taskDescription: String
    var taskDate: Date
}

