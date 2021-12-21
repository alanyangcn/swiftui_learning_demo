//
//  CustomTabView.swift
//  CustomSideMenu (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var currentTab: Tab
    @Binding var showMenu: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    withAnimation(.spring()) {
                        showMenu = true
                    }
                } label: {
                    Image(systemName: "line.3.horizontal.decrease")
                        .font(.title)
                        .foregroundColor(.white)
                }
                .opacity(showMenu ? 0 : 1)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Image(systemName: "sun.max")
                        .resizable()
                        .aspectRatio( contentMode: .fill)
                        .frame(width: 35, height: 35)
                        .foregroundColor(.white)
                }
            }
            .overlay(
                Text(currentTab.title)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .opacity(showMenu ? 0 : 1)
            )
            .padding([.horizontal, .top])
            .padding(.bottom, 8)
            .padding(.top, getSafeArea().top)
            
            TabView(selection: $currentTab) {
                ForEach(Tab.allCases.indices) { index in
                    let tab = Tab.allCases[index]
                    switch tab {
                    case .home:
                        HomeView()
                    default:
                        Text(tab.title)
                            .tag(tab)
                    }
                    
                }
            }
            
            
        }
        .disabled(showMenu)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(
            Button {
                withAnimation(.spring()) {
                    showMenu = false
                }
            } label: {
                Image(systemName: "xmark")
                    .font(.title)
                    .foregroundColor(.white)
            }
                .opacity(showMenu ? 1 : 0)
                .padding()
                .padding(.top)
            , alignment: .topLeading
        )
        .background(
            Color.black
        )
    }
}

struct CustomTabView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
