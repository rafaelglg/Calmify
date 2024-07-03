//
//  LoginViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation

@Observable
final class LoginViewModel {
    
    let authManager: AuthenticationManagerProtocol
    var email: String = ""
    var password: String = ""
    var isLoggedIn: Bool = false
    var goToLoginView: Bool = false

    
    init(authManager: AuthenticationManagerProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            return
        }
        try await authManager.createUser(email: email, password: password)
        isLoggedIn = true
        goToLoginView = false

    }
    
    func signIn() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            return
        }
        
        try await authManager.signIn(email: email, password: password)
        isLoggedIn = true
        goToLoginView = false
    }
    
    func logOut() throws {
        try authManager.logOut()
        isLoggedIn = false
        goToLoginView = true
    }
}
