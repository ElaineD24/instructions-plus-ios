//
//  LoginView.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//

import SwiftUI

let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
//var isNewUser: Bool = false

struct LoginView : View {
    
    @State var username: String = ""
    @State var password: String = ""
    
    @State var authenticationDidFail: Bool = false
    @State var authenticationDidSucceed: Bool = false
    
    @State var editingMode: Bool = false
    @State var isNewUser: Bool = false
    
//    let apiController = UserAuthController()
    
    var body: some View {
        
        ZStack {
            VStack {
                WelcomeText()
                ChoiceText()
                UsernameTextField(username: $username, editingMode: $editingMode)
                PasswordSecureField(password: $password)
                
                Button(action: {
                    let user = Users(username: username, password: password)
                    var resultMessage : String = ""

                    guard let encoded = try? JSONEncoder().encode(user) else {
                        print("Failed to encode order")
                        return
                    }
                    
                    let url = URL(string: Constant.APIUserAuth)!
                    var request = URLRequest(url: url)
                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                    request.httpMethod = "POST"
                    request.httpBody = encoded
                    
                    URLSession.shared.dataTask(with: request) { data, response, error in
                        if let data = data {
                              do {
                                 let res = try JSONDecoder().decode(Messages.self, from: data)
                                 resultMessage = res.message
                                
                                if resultMessage == "Authentication Successful" {
                                    self.authenticationDidSucceed = true
                                    self.authenticationDidFail = false
                                    self.hideKeyboard()
                                } else {
                                    self.authenticationDidFail = true
                                    self.hideKeyboard()
                                }
                                 print(resultMessage)
                              } catch let error {
                                 print(error)
                              }
                           }
                    }.resume()

                }) {
                    LoginButtonContent()
                }
               
                Button("Sign Up") {
                            self.isNewUser = true
                }.padding(.top, 10.0).sheet(isPresented: $isNewUser, content: {
                            SignUpView(isNewUser: self.$isNewUser)
                        })
            }

            .padding(0.0)
            
            if authenticationDidFail {
                Text("Information not correct. Try again.")
                    .offset(y: -10)
                    .foregroundColor(.red)
            }
            if authenticationDidSucceed {
                ContentView()
            }
        }
            .offset(y: editingMode ? -5 : 0)
    }
}

#if DEBUG
struct LoginView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif

struct WelcomeText : View {
    var body: some View {
        return Text("Welcome!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .multilineTextAlignment(.center)
            .padding(.bottom, 30.0)
    }
}
struct ChoiceText : View {
    var body: some View {
        return Text("Please login or create an account")
            .font(.system(size: 18))
            .fontWeight(.medium)
            .multilineTextAlignment(.center)
            .padding(.bottom, 15.0)
    }
}

struct LoginButtonContent : View {
    var body: some View {
        return Text("Login")
            .font(.system(size: 20))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(
                LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(8)
    }
}



struct UsernameTextField : View {
    
    @Binding var username: String
    
    @Binding var editingMode: Bool
    
    var body: some View {
        
        return TextField("User Email", text: $username, onEditingChanged: {edit in
            if edit == true
            {self.editingMode = true}
            else
            {self.editingMode = false}
        })
        .padding()
        .background(Color.white)
        .cornerRadius(7)
        .frame(width: UIScreen.main.bounds.width - 30)

    // shadow effect...
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
        .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
    }
}

struct PasswordSecureField : View {
    
    @Binding var password: String
    
    var body: some View {
         
        return SecureField("Password", text: $password)
            .padding()
            .background(Color.white)
            .cornerRadius(7)
            .frame(width: UIScreen.main.bounds.width - 30)
        // shadow effect...
            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)
            .shadow(color: Color.black.opacity(0.08), radius: 5, x: 0, y: -5)
        
    }
}


#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif


struct SignUpView : View {
    
    @State var username: String = ""
    @State var password: String = ""
//    @State var newUser: Users = Users.init()
    
    @State var editingMode: Bool = false
    @Binding var isNewUser:Bool

    let apiController = UserSignUpController()

    var body: some View {
        
        ZStack {
            VStack {
                CreateNewProfileText()
                UsernameTextField(username: $username, editingMode: $editingMode)
                PasswordSecureField(password: $password)
                
                Button(action: {

                
                    apiController.UserSignUpRequest(username: username, password: password)
                    
                    self.hideKeyboard()
                    self.isNewUser = false
                }) {
                    SignUpButtonContent()
                }
                }
                .padding()
            
        }
            .offset(y: editingMode ? -5 : 0)
    }
}

#if DEBUG
struct SignUpView_Previews : PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
#endif

struct CreateNewProfileText : View {
    var body: some View {
        return Text("Create Your Profile")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 30)
    }
}

struct SignUpButtonContent : View {
    var body: some View {
        return Text("Sign Up")
            .font(.system(size: 20))
            .foregroundColor(.white)
            .fontWeight(.bold)
            .padding(.vertical)
            .frame(width: UIScreen.main.bounds.width - 100)
            .background(
            
                LinearGradient(gradient: .init(colors: [Color("Color"),Color("Color1")]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .cornerRadius(8)
    }
}





