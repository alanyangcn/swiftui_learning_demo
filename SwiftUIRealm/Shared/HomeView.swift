//
//  HomeView.swift
//  SwiftUIRealm
//
//  Created by 杨立鹏 on 2021/12/27.
//

import SwiftUI
import RealmSwift
struct HomeView: View {
    @ObservedResults(TaskItem.self, sortDescriptor: SortDescriptor.init(keyPath: "taskDate", ascending: true)) var tasksFetched
    @State var lastAddedTaskId = ""
    var body: some View {
        NavigationView{
            
            ZStack {
                if tasksFetched.isEmpty {
                    Text("Add some new Tasks!")
                        .font(.caption)
                        .foregroundColor(.gray)
                } else {
                    List {
                        ForEach(tasksFetched) { task in
                            TaskRow(task: task, lastAddedTaskID: $lastAddedTaskId)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        $tasksFetched.remove(task)
                                    } label: {
                                        Image(systemName: "trash")
                                    }

                                }
                        }
                        
                    }
                    .listStyle(.insetGrouped)
                    .animation(.easeInOut, value: tasksFetched)
                }
            }
            .navigationTitle("Task's")
            .toolbar {
                Button {
                    let task = TaskItem()
                    lastAddedTaskId = task.id.stringValue
                    $tasksFetched.append(task)
                    
                    
                } label: {
                    Image(systemName: "plus")
                }
                
            }
            .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                lastAddedTaskId = ""
                guard let last = tasksFetched.last else { return  }
                if last.taskTitle == ""{
                    $tasksFetched.remove(last)
                }
            }
        }
        
    }
}

struct TaskRow: View {
    @ObservedRealmObject var task: TaskItem
    
    @Binding var lastAddedTaskID: String
    @FocusState var showKeyboard:Bool
    var body: some View {
        HStack(spacing: 15){
            Menu {
                Button("Missed") {
                    $task.taskStatus.wrappedValue = .missed
                }
                Button("Completed") {
                    $task.taskStatus.wrappedValue = .completed
                }
            } label: {
                Circle()
                    .stroke(.gray)
                    .frame(width: 15, height: 15)
                    .overlay(
                        Circle()
                            .fill(task.taskStatus == .missed ? .red : (task.taskStatus == .pending) ? .yellow : .green)
                    )
            }
            VStack(alignment: .leading, spacing: 12) {
                TextField("Refresh", text: $task.taskTitle)
                    .focused($showKeyboard)
                if task.taskTitle != "" {
                    Picker(selection: .constant("")) {
                        DatePicker(selection: $task.taskDate) {
                            
                        }
                        .labelsHidden()
                        .navigationTitle("Task Date")
                        .datePickerStyle(.graphical)
                    } label: {
                        HStack {
                            Image(systemName: "calendar")
                                
                            Text(task.taskDate.formatted(date: .abbreviated, time: .omitted))
                        }
                    }

                }
            }
        }
        .onAppear {
            if lastAddedTaskID == task.id.stringValue {
                showKeyboard.toggle()
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
