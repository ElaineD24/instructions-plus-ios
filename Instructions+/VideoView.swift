//
//  VideoView.swift
//  Instructions+
//
//  Created by Yizhang Cao on 2021-01-16.
//

import SwiftUI
import AVKit

struct VideoView: View {
    private let player = AVPlayer(url: URL(string: "https://https://the-hidden-tent.s3.amazonaws.com/hls/test.m3u8")!)
    var body: some View {
        VideoPlayer(player: player)
            .onAppear() {
                player.play()
            }
            .onDisappear() {
                player.pause()
            }
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView()
    }
}
