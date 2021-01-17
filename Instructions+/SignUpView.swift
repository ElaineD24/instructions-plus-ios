////
////  SignUpView.swift
////  Instructions+
////
////  Created by Wenyue Deng on 2021-01-16.
////
//
//import SwiftUI
//
//struct SignUpView : View {
//    
//    @State var username: String = ""
//    @State var password: String = ""
////    @State var newUser: Users = Users.init()
//    
//    @State var editingMode: Bool = false
//    let apiController = UserSignUpController()
//
//    var body: some View {
//        
//        ZStack {
//            VStack {
//                CreateNewProfileText()
//                UsernameTextField(username: $username, editingMode: $editingMode)
//                PasswordSecureField(password: $password)
//                
//                Button(action: {
//
//                
//                    apiController.UserSignUpRequest(username: username, password: password)
////                    switch result {
////                        case let .success(data):
////                            guard let messages = data else {                      self.hideKeyboard()
////                                return
////                            }
////
////                    case .failure(_):
////                            self.hideKeyboard()
////                            return
////                    }
//                    self.hideKeyboard()
//                    LoginView()
//                
//                }) {
//                    SignUpButtonContent()
//                }
//                }
//                .padding()
//            
//        }
//            .offset(y: editingMode ? -5 : 0)
//    }
//}
//
//#if DEBUG
//struct SignUpView_Previews : PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
//#endif
//
//struct CreateNewProfileText : View {
//    var body: some View {
//        return Text("Create Your Profile")
//            .font(.largeTitle)
//            .fontWeight(.semibold)
//            .padding(.bottom, 20)
//    }
//}
//
//struct SignUpButtonContent : View {
//    var body: some View {
//        return Text("Sign Up")
//            .font(.system(size: 20))
//            .foregroundColor(.white)
//            .fontWeight(.bold)
//            .padding(.vertical)
//            .frame(width: UIScreen.main.bounds.width - 50)
//            .background(
//            
//                LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
//            )
//            .cornerRadius(8)
//    }
//}
//
//
//
//
//
