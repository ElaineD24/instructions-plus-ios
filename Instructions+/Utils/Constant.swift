//
//  Constant.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import Foundation

enum Constant {
    static let HOST = "http://192.168.1.26:3550"
    static let APIGetInfo = HOST
//    static let APIUserAuth = "http://192.168.1.255/auth/login"
//    static let APINewUser = "http://192.168.1.255/auth/register"
    static let APIUserAuth = HOST + "/auth/login"
    static let APINewUser = HOST + "/auth/register"

    
}
