//
//  LoginViewModel.swift
//  LoginScreen
//
//  Created by Poonam Pandey on 26/10/22.
//

import Foundation

public class LoginViewModel: ObservableObject {
    @Published var loginForm = LoginFormState(username: "", password: "")
    
    public func authenticateUser() {
        
    }
}

struct LoginFormState {
    var username: String = ""
    var password: String = ""
}
