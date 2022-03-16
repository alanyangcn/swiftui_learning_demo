//
//  Home.swift
//  SpotifyResponvieUI (iOS)
//
//  Created by 杨立鹏 on 2022/3/16.
//

import SwiftUI

struct Home: View {
    
    @State var currentType: String = "Popular"
    @Namespace var animation
    
    @State var _albums: [Album] = albums
    
    @State var headerOffsets: (CGFloat, CGFloat) = (0, 0)
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 0) {
                HeaderView()
                
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    Section {
                        SongList()
                    } header: {
                        PinnedHeaderView()
                            .background(.black)
                            .offset(y: headerOffsets.1 > 0 ? 0 : -headerOffsets.1 / 8)
                            .modifier(OffsetModifier(offset: $headerOffsets.0, returnFromStart: false))
                            .modifier(OffsetModifier(offset: $headerOffsets.1))
                    }
                }
            }
        }
        .overlay(content: {
            Rectangle()
                .fill(.black)
                .frame(height: 50)
                .frame(maxHeight: .infinity, alignment: .top)
                .opacity(headerOffsets.0 < 5 ? 1 : 0)
        })
        .coordinateSpace(name: "SCROLL")
        .ignoresSafeArea(.container, edges: .vertical)
    }
    
    
    @ViewBuilder
    func SongList() -> some View {
        VStack(spacing: 25){
            ForEach($_albums) {$album in
                HStack(spacing : 12) {
                    
                    Text("#\(getIndex(album: album) + 1)")
                        .fontWeight(.semibold)
                        .foregroundColor(.gray)
                    
                    Image(album.albumImage)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 55, height: 55)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(album.albumName)
                            .fontWeight(.semibold)
                        
                        Label {
                            Text("23,523,492")
                                
                        } icon: {
                            Image(systemName: "beats.headphones")
                                .foregroundColor(.white)
                        }
                        .foregroundColor(.gray)
                        .font(.caption)
                        
                    }
                    
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button {
                        album.isLiked.toggle()
                    } label: {
                        Image(systemName: album.isLiked ? "suit.heart.fill" : "suit.heart")
                            .font(.title3)
                            .foregroundColor(album.isLiked ? .red : .white)
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.title3)
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .padding()
        .padding(.top, 25)
        .padding(.bottom, 150)
        
    }
    
    
    func getIndex(album: Album) -> Int {
        _albums.firstIndex { currentAlbum in
            album.id == currentAlbum.id
        } ?? 0
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        GeometryReader { proxy in
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let size = proxy.size
            let height = (size.height + minY)
            Image("mojiezuo")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: size.width
                       , height: height > 0 ? height : 0, alignment: .top)
                .overlay(content: {
                    ZStack(alignment: .bottom) {
                        LinearGradient(colors: [
                            .clear,
                            .black.opacity(0.8)
                        ], startPoint: .top, endPoint: .bottom)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("周杰伦")
                                .font(.callout)
                                .foregroundColor(.gray)
                            
                            HStack(alignment: .bottom, spacing: 10) {
                                Text("魔杰座")
                                    .font(.title2.bold())
                                Image(systemName: "checkmark.seal.fill")
                                    .foregroundColor(.blue)
                                    .background{
                                        Circle()
                                            .fill(.white)
                                            .padding(3)
                                    }
                            }
                            
                            
                            Label {
                                Text("当月听众")
                                    .fontWeight(.semibold)
                                    .foregroundColor(.white.opacity(0.7))
                            } icon: {
                                Text("143,234,139")
                                    .fontWeight(.semibold)
                            }
                            .font(.caption)
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 25)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    
                })
                .cornerRadius(15)
                .offset(y: -minY)
        }
        .frame(height: 250)
    }
    
    @ViewBuilder
    func PinnedHeaderView() -> some View {
        let types = ["Popular", "Albums", "Songs", "Fans Also Like", "About"]
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 25) {
                ForEach(types, id:\.self) { type in
                    VStack(spacing: 12) {
                        Text(type)
                            .fontWeight(.semibold)
                            .foregroundColor(currentType == type ? .white : .gray)
                        
                        ZStack {
                            if currentType == type {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.white)
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            } else {
                                RoundedRectangle(cornerRadius: 4, style: .continuous)
                                    .fill(.clear)
                                   
                            }
                        }
                        .padding(.horizontal, 8)
                        .frame(height: 4)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            currentType = type
                        }
                    }
                }
            }
            .padding(.horizontal)
            .padding(.top, 25)
            .padding(.bottom, 5)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
