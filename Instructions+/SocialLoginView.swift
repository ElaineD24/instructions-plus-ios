////
////  ContentView.swift
////  signin
////
//
//// add your google plist before running it to avoid crashes
//// also add reserved client id
//
//import SwiftUI
//import GoogleSignIn
//
//struct SocialLoginView: View {
//    var body: some View {
//
//        google().frame(width: 120, height: 50)
//    }
//}
//
//struct SocialLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        SocialLoginView()
//    }
//}
//
//struct google : UIViewRepresentable {
//
//
//    func makeUIView(context: UIViewRepresentableContext<google>) -> GIDSignInButton {
//
//        let button = GIDSignInButton()
//        button.colorScheme = .dark
//        GIDSignIn.sharedInstance()?.presentingViewController = UIApplication.shared.windows.last?.rootViewController
//        return button
//    }
//    func updateUIView(_ uiView: GIDSignInButton, context: UIViewRepresentableContext<google>) {
//
//    }
//}
