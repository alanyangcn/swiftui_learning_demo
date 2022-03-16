//
//  Ring.swift
//  MinimalAnimation-2 (iOS)
//
//  Created by 杨立鹏 on 2022/3/14.
//

import SwiftUI


struct Ring: Identifiable {
    var id = UUID().uuidString
    var progress: CGFloat
    var value: String
    var keyIcon: String
    var keyColor: Color
    var isText: Bool = false
    
}

var rings = [
    Ring(progress: 72, value: "Step", keyIcon: "figure.walk", keyColor: .green),
    Ring(progress: 36, value: "Calories", keyIcon: "flame.fill", keyColor: .pink),
    Ring(progress: 91, value: "Sleep time", keyIcon: "😄", keyColor: .cyan, isText: true)
]
