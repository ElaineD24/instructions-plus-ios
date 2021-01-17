////
////  UserAuthController.swift
////  Instructions+
////
////  Created by Wenyue Deng on 2021-01-16.
////
//
//import Foundation
//
//class UserAuthController {
//    func makeGetUserRequest(username: String, password: String) -> String {
//        let user = Users(username: username, password: password)
//        var resultMessage : String = ""
//        guard let encoded = try? JSONEncoder().encode(user) else {
//            print("Failed to encode order")
//            return resultMessage
//        }
//
//        let url = URL(string: Constant.APIUserAuth)!
//        var request = URLRequest(url: url)
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "POST"
//        request.httpBody = encoded
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            if let data = data {
//                  do {
//                     let res = try JSONDecoder().decode(Messages.self, from: data)
//                     resultMessage = res.message
//                     print(res.message)
//                  } catch let error {
//                     print(error)
//                  }
//               }
//        }.resume()
//        return resultMessage
//    }
//}
