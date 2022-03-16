//
//  Album.swift
//  SpotifyResponvieUI (iOS)
//
//  Created by 杨立鹏 on 2022/3/16.
//

import SwiftUI


struct Album: Identifiable {
    var id = UUID().uuidString
    var albumName: String
    var albumImage: String
    var isLiked = false
}

var albums = [
    Album(albumName: "七里香", albumImage: "qilixiang"),
    Album(albumName: "我很忙", albumImage: "wohenmang"),
    Album(albumName: "依然范特西", albumImage: "yiranfantexi"),
    Album(albumName: "十一月的肖邦", albumImage: "shiyiyuedexiaobang"),
    Album(albumName: "叶惠美", albumImage: "yehuimei"),
    Album(albumName: "八度空间", albumImage: "badukongjian"),
    Album(albumName: "12新作", albumImage: "shierxinzuo"),
    Album(albumName: "魔杰座", albumImage: "mojiezuo"),
    Album(albumName: "周杰伦的床边故事", albumImage: "chuangbiangushi")
]
