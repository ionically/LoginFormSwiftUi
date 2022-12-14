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
struct ForgotPasswordResponse: Codable {
    let message: String?
    let status: String?
}
    
struct FindMeResponse: Codable {
    let message: String?
    let status: String?
}
    

public class LoginViewModel: ObservableObject {
    @Published var loginForm = LoginFormState(username: "", password: "")
    @Published var showingLoginScreen: Bool = false
    @Published var displayMessage: String = ""
    @Published var footerMessage: String = ""
    @Published var Message: String = ""
    
    
    public func callLogin() {
        let loginReponse = getLoginResponse()
        if loginReponse?.Token?.isEmpty == false {
            self.showingLoginScreen = true
            showMessage()
        }
    }
    
    public func callForgotPassword() {
        let response = getForgotPasswordResponse()
        if response?.status == "success" {
            showForgetPasswordMessage()
        }
    }
    
    public func callFindMe() {
        let response = getFindMeResponse()
        if response?.status == "success" {
            showFindMeMessage()
        }
    
    }
    
    func getForgotPasswordResponse() -> ForgotPasswordResponse? {

        if let file = readLocalFile(forName: "forgotpassword"), let response = parseForgotPassword(jsonData: file) {
            return response
        }
        return nil
    }

    func getLoginResponse() -> LoginResponse? {
        if let file = readLocalFile(forName: "login-api-success"), let response = parseLogin(jsonData: file) {
            return response
        }
        return nil
    }
    
    func getFindMeResponse() -> FindMeResponse? {

        if let file = readLocalFile(forName: "findme"), let response = parseFindMe(jsonData: file) {
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
   
    func parseLogin(jsonData: Data) -> LoginResponse? {
        do {
            let decodedData = try JSONDecoder().decode(LoginResponse.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
    func parseForgotPassword(jsonData: Data) -> ForgotPasswordResponse? {
        do {
            let decodedData = try JSONDecoder().decode(ForgotPasswordResponse.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
    func parseFindMe(jsonData: Data) -> FindMeResponse? {
        do {
            let decodedData = try JSONDecoder().decode(FindMeResponse.self, from: jsonData)
            return decodedData
        } catch {
            print("decode error")
        }
        return nil
    }
    
    func showMessage() {
        displayMessage = "You are logged in @" + loginForm.username + " nice to meet you"
    }
    func   showForgetPasswordMessage() {
        footerMessage = "email has been sent to your email id"
    }
    func showFindMeMessage() {
        Message = "We are sending more information for finding the details "
    }
}
