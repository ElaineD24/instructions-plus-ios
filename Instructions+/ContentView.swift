//
//  ContentView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-15.
//

import SwiftUI


struct ContentView: View {
    @State private var if_scan = false

    var body: some View {

        NavigationView {
            VStack {
                Image(systemName: "barcode.viewfinder")
                Text("Scan")
                    .font(.title)
                NavigationLink(destination: ScannerView()) {
                    Text("Do Something")
                }
            }
        }
//        ScannerView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
