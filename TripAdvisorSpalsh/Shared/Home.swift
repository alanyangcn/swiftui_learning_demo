//
//  Home.swift
//  TripAdvisorSpalsh
//
//  Created by 杨立鹏 on 2021/12/20.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                
                VStack(spacing: 15) {
                    
                    ForEach(1..<6, id: \.self) { index in
                        
                        GeometryReader { proxy in
                            
                            let size = proxy.size
                            
                            Image("bg_\(index)")
                                .resizable()
                                .aspectRatio( contentMode: .fill)
                                .frame(width:size.width, height: size.height)
                                .cornerRadius(15)
                        }
                        .frame(height: 250)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
