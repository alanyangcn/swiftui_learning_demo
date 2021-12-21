//
//  HomeView.swift
//  CustomSideMenu (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ScrollView {
            ForEach(0..<6) { index in
                Image("bg_\(index)")
                    .resizable()
                    .aspectRatio( contentMode: .fit)
                    .cornerRadius(15)
                    .padding(.vertical, 5)
            }
            .padding(.horizontal)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
