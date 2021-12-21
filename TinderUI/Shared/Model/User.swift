//
//  User.swift
//  TinderUI (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

struct User: Identifiable {
    var id = UUID().uuidString
    var name: String
    var place: String
    var profilePic: String
}

