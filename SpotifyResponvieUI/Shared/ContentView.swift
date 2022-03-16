//
//  ContentView.swift
//  Shared
//
//  Created by 杨立鹏 on 2022/3/16.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .preferredColorScheme(.dark)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
