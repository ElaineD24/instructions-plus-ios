//
//  VideoView.swift
//  Instructions+
//
//  Created by Yizhang Cao on 2021-01-16.
//

import SwiftUI
import AVKit

struct VideoView: View {
    private let queuePlayer: AVQueuePlayer
    
    init(videoUrls: VideoUrls, showingVideo: Bool) {
        var playerItems: [AVPlayerItem] = []
        for url in videoUrls.getModel() {
            print(url)
            playerItems.append(AVPlayerItem(url: URL(string: url)!))
        }
        self.queuePlayer = AVQueuePlayer(items: playerItems)
    }
    
    var body: some View {
        VideoPlayer(player: queuePlayer)
            .onAppear() {
                queuePlayer.play()
            }
            .onDisappear() {
                queuePlayer.pause()
            }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .local)
                .onEnded({ value in
                    if value.translation.width < 0 {
                        // left
                    }

                    if value.translation.width > 0 {
                        // right
                    }
                    if value.translation.height < 0 {
                        queuePlayer.advanceToNextItem()
                        // up
                    }

                    if value.translation.height > 0 {
                        // down
                    }
            }))
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoUrls: VideoUrls(), showingVideo: false)
    }
}
