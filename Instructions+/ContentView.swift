//
//  ContentView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-15.
//

import SwiftUI

enum ActiveSheet: Identifiable {
    case first, second
    
    var id: Int {
        hashValue
    }
}

struct ContentView: View {
    @State private var image: Image?
    @State private var showingVideo = false
    @State private var urls: VideoUrls?
    @State private var inputUrls: VideoUrls?
    @State private var inputImage: UIImage?
    @State private var pickedUrl: URL?
    @State private var isShown = false
    @State private var activeSheet: ActiveSheet?



    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.bottom)
            VideoView(videoUrls: urls ?? VideoUrls(urls: ["https://the-hidden-tent.s3.amazonaws.com/intro.mp4"]), showingVideo: showingVideo)
            VStack {
                HStack {
                    Button(action: {
                        self.activeSheet = .first
                        print("clicking")
                    }) {
                        Image(systemName: "archivebox.fill").frame(width: 200)
                    }.padding(.leading)
                    Spacer()
                    Button(action: {
                        self.activeSheet = .second
                    }) {
                        Image(systemName: "barcode.viewfinder").frame(width: 200)
                    }
                }
                .padding(.top)
                .padding(.trailing)
                Spacer()
            }
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text("Hello")
                        .foregroundColor(.white)
                        .transition(.slide)
                }
            }
            .sheet(item: $activeSheet, onDismiss: loadVideoUrls) { item in
                        switch item {
                        case .first:
                            ImagePicker(image: $inputImage, url: $pickedUrl, isShown: $isShown)
                        case .second:
                            ScannerView(videoUrls: $inputUrls)
                        }
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
