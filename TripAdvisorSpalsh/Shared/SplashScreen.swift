//
//  SplashScreen.swift
//  TripAdvisorSpalsh
//
//  Created by 杨立鹏 on 2021/12/20.
//

import SwiftUI

struct SplashScreen: View {
    
    @State var animationValues: [Bool] = Array(repeating: false, count: 10)
    
    var body: some View {
        ZStack {
            // home view
            GeometryReader { proxy in
                let size = proxy.size
                Home()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    .offset(y: animationValues[6] ? 0 : (size.height + 50))
            }
            // splash screen
            if !animationValues[7] {
                VStack {
                    ZStack {
                        
                        if animationValues[1] {
                            Circle()
                                .fill(.black)
                                .frame(width: 30, height: 30)
                                .overlay(
                                    Rectangle()
                                        .fill(.white)
                                        .frame(height: animationValues[5] ? nil : 0)
                                        .frame(maxHeight: .infinity, alignment: .top)
                                        .padding(.bottom, 5)
                                )
                                .offset(x: animationValues[2] ? 35 : 0)
                        }
                        
                        Circle()
                            .fill(.black)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Rectangle()
                                    .fill(.white)
                                    .frame(height: animationValues[5] ? nil : 0)
                                    .frame(maxHeight: .infinity, alignment: .top)
                                    .padding(.bottom, 5)
                            )
                            .scaleEffect(animationValues[0] ? 1 : 0, anchor: .bottom)
                        
                            .offset(x: animationValues[2] ? -35 : 0)
                        
                        ZStack {
                            
                            Circle()
                                .stroke(Color.black, lineWidth: 10)
                                .frame(width: 65, height: 65)
                                .overlay(
                                    Image(systemName: "arrowtriangle.forward.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .rotationEffect(.init(degrees: -150))
                                        .scaleEffect(CGSize(width: 1.5, height: 1))
                                        .offset(x: -10, y:-12)
                                    , alignment: .topLeading
                                )
                                .offset(x: -35)
                            Circle()
                                .stroke(Color.black, lineWidth: 10)
                                .frame(width: 65, height: 65)
                                .overlay(
                                    Image(systemName: "arrowtriangle.forward.fill")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 25, height: 25)
                                        .rotationEffect(.init(degrees: -150))
                                        .scaleEffect(CGSize(width: 1.5, height: 1))
                                        .offset(y:-12)
                                    , alignment: .topTrailing
                                )
                                .offset(x: 35)
                            
                            Circle()
                                .trim(from: 0.6, to: 1)
                                .stroke(Color.black, lineWidth: 10)
                                .frame(width: 130, height: 130)
                                .rotationEffect(Angle.init(degrees: -20))
                                .offset(y: 12)
                                .scaleEffect(1.07)
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .offset(y: 35)
                                .scaleEffect(CGSize(width: 1.3, height: 1   ),anchor: .top)
                                .background(
                                    Circle()
                                        .fill(.black)
                                        .frame(width: 15, height: 15)
                                        .offset(y: 25)
                                    , alignment: .top
                                )
                        }
                        .opacity(animationValues[3] ? 1 : 0)
                    }
                    .scaleEffect(animationValues[3] ? 0.75 : 1)
                    .padding(.horizontal, 30)
                    .drawingGroup()
                    
                    Text("Hello World")
                        .font(.title2.bold())
                        .offset(y: animationValues[4] ? -35 : 0)
                        .opacity(animationValues[4] ? 1 : 0)
                    
                }
                .opacity(animationValues[6] ? 0 : 1)
                .environment(\.colorScheme, .light)
            }
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.3)) {
                animationValues[0] = true
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                animationValues[1] = true
                
                withAnimation(.easeInOut(duration: 0.4).delay(0.1)) {
                    animationValues[2] = true
                }
                
                withAnimation(.easeInOut(duration: 0.3).delay(0.45)) {
                    animationValues[3] = true
                }
                
                withAnimation(.easeInOut(duration: 0.4).delay(0.3)) {
                    animationValues[4] = true
                }
                withAnimation(.easeInOut(duration: 0.4).delay(0.6)) {
                    animationValues[5] = true
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    withAnimation(.easeInOut(duration: 0.3).delay(0.4)) {
                        animationValues[5] = false
                    }
                    
                    withAnimation(.easeInOut(duration: 0.5).delay(0.8)) {
                        animationValues[6] = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        animationValues[7] = true
                    }
                }
            }
        }
    }
}

struct SplashScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}
