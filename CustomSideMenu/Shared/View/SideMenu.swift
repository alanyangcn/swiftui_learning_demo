//
//  SideMenu.swift
//  CustomSideMenu (iOS)
//
//  Created by 杨立鹏 on 2021/12/21.
//

import SwiftUI

enum Tab: CaseIterable {
    case home
    case discover
    case devices
    case profile
    case setting
    case about
    case help
    
    var title: String {
        switch self {
        case .home:
            return "Home"
        case .discover:
            return "Discover"
        case .devices:
            return "Devices"
        case .profile:
            return "Profile"
        case .setting:
            return "Setting"
        case .about:
            return "About"
        case .help:
            return "Help"
        }
    }
    
    var image: String {
        
        switch self {
        case .home:
            return "theatermasks.fill"
        case .discover:
            return "safari.fill"
        case .devices:
            return "applewatch"
        case .profile:
            return "person.fill"
        case .setting:
            return "gearshape.fill"
        case .about:
            return "info.circle.fill"
        case .help:
            return "questionmark.circle.fill"
        }
    }
}

struct SideMenu: View {
    @Binding var currentTab: Tab
    @Binding var showMenu: Bool
    @Namespace var animation
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "sun.max")
                    .resizable()
                    .aspectRatio( contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
                    .foregroundColor(.white)
                Text("iJustine")
                    .font(.title2.bold())
                    .foregroundColor(.white)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(getRect().height < 750 ? .vertical : .init(), showsIndicators: false) {
                VStack(alignment: .leading, spacing: 25) {
                    
                    ForEach(Tab.allCases.indices) { index in
                        let tab = Tab.allCases[index]
                        CustomTabButton(icon: tab.image, title: tab.title)
                    }
                    Spacer()
                    CustomTabButton(icon: "rectangle.portrait.and.arrow.right", title: "Logout")
                    
                }
                .padding()
                .padding(.top, 45)
            }
            .frame(width: getRect().width / 2, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.leading, 10)
        .frame(maxWidth: .infinity, maxHeight: .infinity,alignment: .top)
        .background(
            Color(red: 0.05, green: 0.05, blue: 0.05)
        )
    }
    
    
    @ViewBuilder
    func CustomTabButton(icon: String, title: String) -> some View {
        Button {
            
            if title == "Logout" {
                print("Logout")
            } else {
                withAnimation {
                    let index = Tab.allCases.firstIndex(where: {$0.title == title}) ?? 0
                    let tab = Tab.allCases[index]
                    currentTab = tab
                    showMenu = false
                }
            }
            
            
        } label: {
            HStack(spacing: 12) {
                Image(systemName: icon)
                    .font(.title3)
                    .frame(width: currentTab.title == title ? 48 : nil, height: 48)
                    .foregroundColor(currentTab.title == title ? .purple : (title == "Logout" ? .orange : .white))
                    .background(
                        ZStack {
                            if currentTab.title == title {
                                Color.white
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TABCIRCLE", in: animation)
                            }
                        }
                        
                    )
                Text(title)
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundColor(title == "Logout" ? .orange : .white)
            }
            .padding(.trailing, 18)
            .background(
                ZStack {
                    if currentTab.title == title {
                        Color.purple
                            .clipShape(Capsule())
                            .matchedGeometryEffect(id: "TABCAPSULE", in: animation)
                    }
                }
               
            )
        }
        .offset(x: currentTab.title == title ? 15 : 0)
    }
}

struct SideMenu_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
}
