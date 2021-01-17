//
//  Users.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import Foundation

class Users: Codable {
    let username: String
    let password: String

    enum CodingKeys: String, CodingKey {
        case username
        case password
    }

    init() {
        username = ""
        password = ""
    }

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
