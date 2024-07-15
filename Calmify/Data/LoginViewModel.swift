//
//  LoginViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation

@Observable @MainActor
final class LoginViewModel {
    
    @ObservationIgnored let authManager: AuthenticationManagerProtocol
    var email: String = ""
    var password: String = ""
    var name: String = ""
    var lastName: String = ""
    var phoneNumber: String = ""
    var isLoggedIn: Bool = false
    var goToSignInView: Bool = false
    var goToSignUpView: Bool = false
    var goToHomeView: Bool = false
    var buttonIsEnable: Bool = false
    var goToResetPasswordView: Bool = false
    
    init(authManager: AuthenticationManagerProtocol = AuthenticationManager.shared) {
        self.authManager = authManager
    }
    
    func signUp() async throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            throw ErrorManager.noInfoInSignUp
        }
        try await authManager.createUser(email: email, password: password)
        isLoggedIn = true
        goToSignInView = false
    }
    
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
    
    func resetPassword(for givenEmail: String) async throws {
        
        guard !givenEmail.isEmpty else {
            throw ErrorManager.noEmailFoundForReset
        }
        
        try await authManager.resetPassword(email: givenEmail)
    }
    
    func buttonEnableForSignUp() {
        
        let fullName = !name.isEmpty
        let email = email.count > 6 && email.contains("@")
        let password = password.count >= 6
        let phoneNumber = phoneNumber.count > 8 && phoneNumber.count < 15
        
        buttonIsEnable = (fullName && email && password && phoneNumber)
    }
}

// MARK: - Sign In with Google
extension LoginViewModel {
    
    func signInWithGoogle() async throws {
        
        let tokens = try await SignInGoogleManager().signIn()
        
        try await authManager.signInWithGoogle(idTokens: tokens)
        isLoggedIn = true
    }
}
