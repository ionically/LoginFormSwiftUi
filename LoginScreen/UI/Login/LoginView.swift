//
//  ContentView.swift
//  LoginScreen
//
//  Created by Federico on 13/11/2021.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject private(set) var viewmodel: LoginViewModel
    
    @State private var wrongUsername: Float = 0
    @State private var wrongPassword: Float  = 0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.red
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.15))
                Circle()
                    .scale(1.35)
                    .foregroundColor(.white)

                VStack {
                    Text("Sign In")
                        .font(.largeTitle)
                        .bold()
                        .padding()
                    
                    TextField("Username", text: $viewmodel.loginForm.username)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.purple.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongUsername))
                        
                    
                    SecureField("Password", text: $viewmodel.loginForm.password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.purple.opacity(0.05))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    
                    Button("Login") {
                        viewmodel.authenticateUser()
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.blue)
                    .cornerRadius(10)
                    
                    NavigationLink(destination: Text("You are logged in @\(viewmodel.loginForm.username) \(viewmodel.displayMessage)"),
                                   isActive: $viewmodel.showingLoginScreen) {
                        EmptyView()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewmodel: .init())
    }
}
