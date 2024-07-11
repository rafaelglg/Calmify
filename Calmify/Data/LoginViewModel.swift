//
//  LoginViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation

@Observable
final class LoginViewModel {
    
    @ObservationIgnored let authManager: AuthenticationManagerProtocol
    @MainActor var email: String = ""
    var password: String = ""
    var name: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var isLoggedIn: Bool = false
    var goToSignInView: Bool = false
    var goToSignUpView: Bool = false
    var goToHomeView: Bool = false
    
    init(authManager: AuthenticationManagerProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    @MainActor
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            throw ErrorManager.noInfoInSignUp
        }
        try await authManager.createUser(email: email, password: password)
        isLoggedIn = true
        goToSignInView = false
    }
    
    @MainActor
    func signIn() async throws {
        
        guard !email.isEmpty, !password.isEmpty else {
            throw ErrorManager.noInfoInSignIn
        }
        
        try await authManager.signIn(email: email, password: password)
        isLoggedIn = true
        goToSignInView = false
    }
    
    func logOut() throws {
        try authManager.logOut()
        isLoggedIn = false
        goToSignInView = true
    }
}
