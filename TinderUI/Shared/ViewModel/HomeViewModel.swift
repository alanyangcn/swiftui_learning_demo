//
//  HomeViewModel.swift
//  TinderUI (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var fetched_users: [User] = []
    
    @Published var displaying_users: [User]?
    
    init() {
        fetched_users = [
            User(name: "南宫仆射", place: "石家庄市", profilePic: "user1"),
            User(name: "红薯", place: "北京市", profilePic: "user2"),
            User(name: "姜泥", place: "上海市", profilePic: "user3"),
            User(name: "青鸟", place: "呼和浩特市", profilePic: "user4"),
            User(name: "舒羞", place: "青岛市", profilePic: "user5")
        ]
        
        displaying_users = fetched_users
    }
    
    func getIndex(user: User) -> Int {
        displaying_users?.firstIndex(where: {user.id == $0.id}) ?? 0
    }
}

