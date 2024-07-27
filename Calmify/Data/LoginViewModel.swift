//
//  LoginViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation

@Observable
final class LoginViewModel {
    
    @ObservationIgnored let googleManager: SignInGoogleManagerProtocol
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
    var showErrorAlert: Bool = false
    var showSuccessAlert: Bool = false
    var errorMessage: String = ""
    var errorType: ErrorManager?
    var user: AuthDataResultModel?
    
    init(authManager: AuthenticationManagerProtocol = AuthenticationManager.shared, googleManager: SignInGoogleManagerProtocol = SignInGoogleManager()) {
        self.authManager = authManager
        self.googleManager = googleManager
    }
    
    @MainActor
    func signUp() async throws {
        try signUpError()
        try await authManager.createUser(email: email, password: password)
        isLoggedIn = true
        goToSignInView = false
    }
    
    func loadCurrentUser() throws {
        do {
            self.user = try authManager.getAuthenticatedUser()
        } catch {
            print("error en loadCurrentUser: \(error.localizedDescription)")
        }
    }
    
    @MainActor
    func signIn() async throws {
        try signInError()
        try await authManager.signIn(email: email, password: password)
        isLoggedIn = true
        goToSignInView = false
    }
    
    func logOut() throws {
        try authManager.logOut()
        isLoggedIn = false
        goToSignInView = true
    }
    
    func deleteUser() async throws {
        do {
            try await authManager.deleteUser()
        } catch {
            throw ErrorManager.reauthenticationRequired
        }
    }
    
    func resetPassword(for givenEmail: String) async throws {
        
        guard NetworkManager.shared.isConnected else {
            throw ErrorManager.noInternetConnection
        }
        
        guard !givenEmail.isEmpty else {
            throw ErrorManager.emptyEmail
        }
        
        try await authManager.resetPassword(email: givenEmail)
    }
    
    func buttonEnableForSignUp() {
        
        let fullName = !name.isEmpty
        let email = email.count > 6 && email.contains("@")
        let password = password.count >= 6
        
        buttonIsEnable = (fullName && email && password)
    }
}

// MARK: - Error handling
extension LoginViewModel {
    
    func signUpError() throws {
        guard !email.isEmpty, !password.isEmpty else {
            print("no email or password")
            throw ErrorManager.noInfoInSignUp
        }
        
        guard password.count >= 6 else {
            throw FirebaseAuthError.weakPassword
        }
        
        guard NetworkManager.shared.isConnected else {
            throw ErrorManager.noInternetConnection
        }
    }
    
    func signInError() throws {
        guard password.count >= 6 else {
            throw FirebaseAuthError.weakPassword
        }

        guard NetworkManager.shared.isConnected else {
            throw ErrorManager.noInternetConnection
        }
        
        guard !email.isEmpty, !password.isEmpty else {
            throw ErrorManager.noInfoInSignIn
        }
    }
}

// MARK: - Sign In with Google
extension LoginViewModel {
    
    @MainActor
    func signInWithGoogle() async throws {
        
        let tokens = try await googleManager.signIn()
        
        try await authManager.signInWithGoogle(idTokens: tokens)
        isLoggedIn = true
    }
    
    func reAuthenticateUserWithGoogle() async throws {
        let tokens = try await googleManager.signIn()
        try await authManager.reAuthenticateUserWithGoogle(idTokens: tokens)
    }
    
}
