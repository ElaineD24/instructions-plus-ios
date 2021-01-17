//
//  UserSignUpController.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import Foundation

class UserSignUpController {
    func UserSignUpRequest(username: String, password: String){
//        guard let url = URL(string: Constant.APINewUser) else { return .failure(.url) }
//        var requestRet: Result<Messages?, NetworkError>!
//        let semaphore = DispatchSemaphore(value: 0)
        let user = Users(username: username, password: password)
        guard let encoded = try? JSONEncoder().encode(user) else {
            print("Failed to encode order")
            return
        }
        
        let url = URL(string: Constant.APINewUser)!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error took place \(error)")
//                requestRet = .failure(error as! NetworkError)
                return
            }
//            print(data)
//            print(response)
            do{
                let messages = try? JSONDecoder().decode(Messages.self, from: data!)
//                requestRet = .success(messages)
                return
                
            } catch {
//                requestRet = .failure(.dataFormat)
            }
            
        }.resume()
        
//        return requestRet
    }
}
//
//func GenerateUserTokenApiCall(useremail: String, password: String) -> Users {
//    let apiController = UserSignUpController()
//    // Here it's running in the forground, later maybe change it to the background with another thread. For know-how, see comments in APIController
//    let result = apiController.makeGenerateTokenRequest(useremail: useremail, password: password)
//    switch result {
//    case let .success(data):
//        guard let user = data else {
//            return Users()
//        }
//        return user
//    case let .failure(error):
//        return Users()
//    }
//}
