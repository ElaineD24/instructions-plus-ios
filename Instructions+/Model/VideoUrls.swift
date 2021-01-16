//
//  VideoUrls.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import Foundation

class VideoUrls: ObservableObject {
    
    var urls: [String]
    
    init() {
        urls = []
    }
    
    init(urls: [String]) {
        self.urls = urls
    }
    
    func getModel() -> [String] {
        return urls
    }
}
