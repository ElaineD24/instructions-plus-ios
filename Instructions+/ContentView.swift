//
//  ContentView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-15.
//

import SwiftUI


struct ContentView: View {
    @State private var showingScanner = false
    @State private var urls: VideoUrls?
    @State private var inputUrls: VideoUrls?

    var body: some View {

        NavigationView {
            VStack {
                Image(systemName: "barcode.viewfinder")
                Button("Scan") {
                    self.showingScanner = true
                }.font(.title)
            }
            .sheet(isPresented: $showingScanner, content: {
                ScannerView(videoUrls: inputUrls)
            }, )
        }
//        ScannerView()
    }
    
    func loadVideoUrls() -> VideoUrls {
        guard let inputVideoUrls = inputVideoUrls else { return VideoUrls() }
        urls = inputVideoUrls
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
