//
//  HomeView.swift
//  AdvancedScroll
//
//  Created by 杨立鹏 on 2021/12/27.
//

import SwiftUI
var links = [
    Link(title: "Tumblr", logo: "flame"),
    Link(title: "Twitter", logo: "tortoise"),
    Link(title: "Instagram", logo: "ant"),
    Link(title: "Google", logo: "hare"),
    Link(title: "Dribbble", logo: "leaf"),
    Link(title: "Pinterest", logo: "ladybug")
    
]
struct HomeView: View {
    
    var bgColor = Color(red: 0.15, green: 0.15, blue: 0.15)
    @State var offset: CGFloat = 0
    @State var delegate = ScrollViewDelegate()
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            ScrollContent(showTitle: false)
            .padding(.top, getRect().height / 3)
            .padding(.bottom, CGFloat(links.count - 1) * 80)
            .overlay(
                GeometryReader { _ in
                    ScrollContent(showTitle: true)
                }
                    .frame(height: 80)
                    .offset(y: offset)
                    .clipped()
                    .background(.yellow)
                    .padding(.top, getRect().height / 3)
                    .offset(y: -offset)
                ,alignment: .top
            )
            .modifier(OffSetModifier(offset: $offset))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .background(bgColor)
        .ignoresSafeArea()
        .coordinateSpace(name: "SCROLL")
        .onAppear {
            UIScrollView.appearance().delegate = delegate
            UIScrollView.appearance().bounces = false
        }
        .onDisappear {
            UIScrollView.appearance().delegate = nil
            UIScrollView.appearance().bounces = true
        }
    }
    
    @ViewBuilder
    func ScrollContent(showTitle: Bool = false) -> some View {
        VStack(spacing: 0) {
            ForEach(links) {link in
                HStack {
                    if showTitle {
                        Text(link.title)
                            .font(.title2.bold())
                            .foregroundColor(bgColor)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    } else {
                        Spacer()
                    }
                    
                    Image(systemName:link.logo)
                        .resizable()
                        .aspectRatio( contentMode: .fit)
                        .frame(width: 40, height: 40, alignment: .center)
                        .foregroundColor(showTitle ? .yellow : bgColor)
                        .padding(10)
                        .background(showTitle ? bgColor : .yellow)
                        .cornerRadius(40)
                        .padding(5)
                        

                }
                .padding(.horizontal, 15)
                .frame(height: 80)
                
            }
        }
        .padding(.top, getSafeArea().top)
        .padding(.bottom, getSafeArea().bottom)
    }
}

class ScrollViewDelegate: NSObject, ObservableObject, UIScrollViewDelegate {
    
    @Published var snapInterval: CGFloat = 80
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let target = scrollView.contentOffset.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 80 * condition), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let target = targetContentOffset.pointee.y
        let condition = (target / snapInterval).rounded(.toNearestOrAwayFromZero)
        
        scrollView.setContentOffset(CGPoint(x: 0, y: 80 * condition), animated: true)
    }
}

extension View {
    func getRect() -> CGRect {
        UIScreen.main.bounds
    }
    
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero }
        
        return safeArea
    }
}

struct OffSetModifier: ViewModifier {
    @Binding var offset: CGFloat
    
    func body(content: Content) -> some View {
        content.overlay(
        
            GeometryReader { proxy in
                Color.clear
                    .preference(key: OffsetKey.self, value: proxy.frame(in: .named("SCROLL")).minY)
            }
                .onPreferenceChange(OffsetKey.self, perform: { value in
                    self.offset = value
                })
        )
    }
}

struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}


struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
