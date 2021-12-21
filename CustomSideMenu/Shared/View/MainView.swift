//
//  MainView.swift
//  CustomSideMenu (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

struct MainView: View {
    
    @State var currentTab: Tab = .home
    
    @State var showMenu = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            SideMenu(currentTab: $currentTab, showMenu: $showMenu)
            CustomTabView(currentTab: $currentTab, showMenu: $showMenu)
                .cornerRadius(showMenu ? 25 : 0)
                .rotation3DEffect(.init(degrees: showMenu ? -15 : 0), axis: (x: 0, y: 1, z: 0), anchor: .trailing)
                .offset(x: showMenu ? getRect().width / 2 : 0)
                .ignoresSafeArea()
        }
        .preferredColorScheme(.dark)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        return safeArea
    }
}
