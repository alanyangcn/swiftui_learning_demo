//
//  Step.swift
//  MinimalAnimation-2 (iOS)
//
//  Created by 杨立鹏 on 2022/3/14.
//

import SwiftUI


struct Step: Identifiable {
    var id = UUID().uuidString
    var value: CGFloat
    var key: String
    var color: Color = .purple
    
    
}

var steps = [
    Step(value: 500, key: "1-4 AM"),
    Step(value: 240, key: "5-8 AM", color: .green),
    Step(value: 350, key: "9-11 AM"),
    Step(value: 430, key: "12-4 PM", color: .green),
    Step(value: 690, key: "5-8 PM"),
    Step(value: 540, key: "9-12 PM", color: .green)
]
