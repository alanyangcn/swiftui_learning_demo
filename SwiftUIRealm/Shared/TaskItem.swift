//
//  TaskItem.swift
//  SwiftUIRealm
//
//  Created by 杨立鹏 on 2021/12/27.
//

import SwiftUI

import RealmSwift

class TaskItem: Object, Identifiable {
    
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var taskTitle: String
    @Persisted var taskDate = Date()
    
    @Persisted var taskStatus = TaskStatus.pending
    
}

enum TaskStatus: String, PersistableEnum {
    case missed = "Missed"
    case completed = "Completed"
    case pending = "Pending"
}
