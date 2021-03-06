//
//  Home.swift
//  TinderUI (iOS)
//
//  Created by 杨立鹏 on 2021/12/20.
//

import SwiftUI

struct Home: View {
    @StateObject var homeData = HomeViewModel()
    
    var body: some View {
        VStack {
            
            Button {
                withAnimation {
                    homeData.displaying_users = homeData.fetched_users
                }
                
            } label: {
                Image(systemName: "shippingbox.fill")
                    .resizable()
                    .renderingMode(.template)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22, alignment: .center)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .overlay(
                Text("Discover").font(.title.bold())
            )
            .foregroundColor(.black)
            .padding()
            
            ZStack {
                if let users = homeData.displaying_users {
                    
                    if users.isEmpty {
                        Text("Come back later we can find more matches for you!")
                        
                    } else {
                        ForEach(users.reversed()) { user in
                            StackCardView(user: user)
                                .environmentObject(homeData)
                        }
                    }
                    
                } else {
                    ProgressView()
                }
            }
            .padding(.top, 30)
            .padding()
            .padding(.vertical)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            HStack(spacing: 15) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.uturn.backward")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.gray)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe(rightSwipe: true)
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                
                Button {
                    
                } label: {
                    Image(systemName: "star.fill")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(13)
                        .background(Color.yellow)
                        .clipShape(Circle())
                }
                
                Button {
                    doSwipe()
                } label: {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(radius: 5)
                        .padding(18)
                        .background(Color.pink)
                        .clipShape(Circle())
                }
                
            }
            .padding(.bottom)
            .disabled(homeData.displaying_users?.isEmpty ?? false)
            .opacity((homeData.displaying_users?.isEmpty ?? false) ? 0.6 : 1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
    }
    
    func doSwipe(rightSwipe: Bool = false) {
        guard let first = homeData.displaying_users?.first else { return  }
        NotificationCenter.default.post(name: NSNotification.Name("ACTIONFROMBUTTON"), object: nil, userInfo: [
            "id": first.id,
            "rightSwipe": rightSwipe
        ])
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
