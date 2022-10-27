//
//  LoginViewModel.swift
//  LoginScreen
//
//  Created by Poonam Pandey on 26/10/22.
//

import Foundation

struct LoginFormState {
    var username: String = ""
    var password: String = ""
}

struct LoginResponse: Codable {
    let Token: String?
    let message: String?
    let display_msg: String?
}

public class LoginViewModel: ObservableObject {
    @Published var loginForm = LoginFormState(username: "", password: "")
    @Published var showingLoginScreen = false
    
    public func authenticateUser() {
        let loginReponse = getLoginResponse()
        if loginReponse?.Token?.isEmpty == false {
            self.showingLoginScreen = true
        }
    }
    
    func getLoginResponse() -> LoginResponse? {
        if let file = readLocalFile(forName: "login-api-response"), let response = parse(jsonData: file) {
            return response
        }
        return nil
    }
    
    func readLocalFile(forName name: String) -> Data? {
        do {
            if let bundlePath = Bundle.main.path(forResource: name, ofType: "json"),
               let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                return jsonData
            }
        } catch {
            print(error)
        }
        
        return nil
    }
   
    func parse(jsonData: Data) -> LoginResponse? {
        do {
            let decodedData = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
}