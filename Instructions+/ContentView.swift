//
//  ContentView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-15.
//

import SwiftUI


struct ContentView: View {
    @State private var showingScanner = false
    @State private var showingVideo = false
    @State private var urls: VideoUrls?
    @State private var inputUrls: VideoUrls?

    var body: some View {
        ZStack {
            VideoView(videoUrls: urls ?? VideoUrls(urls: ["https://the-hidden-tent.s3.amazonaws.com/intro.mp4"]), showingVideo: showingVideo)
            VStack {
                HStack {
                    Spacer()
                    Image(systemName: "barcode.viewfinder").colorInvert()
                    Button("Scan") {
                        self.showingScanner = true
                    }.font(.title)
                }
                .padding(.top)
                .padding(.trailing)
                Spacer()
            }
            .sheet(isPresented: $showingScanner, onDismiss: loadVideoUrls) {
                ScannerView(videoUrls: $inputUrls)
            }
        }
    }
    
    func loadVideoUrls() {
        guard let inputVideoUrls = inputUrls else { return }
        urls = inputVideoUrls
        self.showingVideo.toggle()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
