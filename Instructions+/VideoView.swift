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
    @State private var isShowVideo = true
    @State private var isCurr = false
    @State private var isPaused = false
    
    init(videoUrls: VideoUrls, showingVideo: Bool) {
        var playerItems: [AVPlayerItem] = []
        for url in videoUrls.getModel() {
            print(url)
            playerItems.append(AVPlayerItem(url: URL(string: url)!))
        }
        self.queuePlayer = AVQueuePlayer(items: playerItems)
        self.isShowVideo = true
        queuePlayer.play()
    }
    
    var body: some View {
        HStack {
            if isShowVideo {
                VideoPlayer(player: queuePlayer)
                    .onAppear() {
                        queuePlayer.play()
                    }
                    .onDisappear() {
                        queuePlayer.pause()
                        withAnimation {
                            self.isShowVideo = true
                        }
                        let currentItem = queuePlayer.currentItem
                        queuePlayer.advanceToNextItem()
                        queuePlayer.insert(currentItem!, after: nil)
                        currentItem?.seek(to: CMTime(seconds: 0.0, preferredTimescale: 600), completionHandler: nil)
                        queuePlayer.play()
                    }.transition(.asymmetric(insertion: AnyTransition.move(edge: .bottom), removal: AnyTransition.move(edge: .top)))
                     .onTapGesture {
                        self.isPaused.toggle()
                        if self.isPaused {
                            queuePlayer.play()
                        } else {
                            queuePlayer.pause()
                        }
                    }
            }
        }.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global)
            .onChanged({ value in
                if value.translation.height < 0 && value.translation.width < 180 && value.translation.width > -180 {
                    if queuePlayer.items().count > 1 {
                        print("change")
                        withAnimation{
                            if !self.isCurr {
                                self.isShowVideo = false
                                self.isCurr = true
                            }
                        }
                    }
                }
            })
                    .onEnded( {
                        value in
                        self.isCurr = false
                    })
        )
    }
}

struct VideoView_Previews: PreviewProvider {
    static var previews: some View {
        VideoView(videoUrls: VideoUrls(), showingVideo: false)
    }
}
