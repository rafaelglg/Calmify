//
//  AuthenticationManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation
import FirebaseAuth


protocol AuthenticationManagerProtocol {
    @discardableResult
    func createUser(email: String, password: String) async throws -> AuthDataResultModel
    func getAuthenticatedUser() throws -> AuthDataResultModel
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel
    func logOut() throws
    func resetPassword(email: String) async throws
    @discardableResult
    func signInWithGoogle(idTokens: GoogleSignInResultModel) async throws -> AuthDataResultModel
    func deleteUser() async throws
    func reAuthenticateUserWithGoogle(idTokens: GoogleSignInResultModel) async throws
}

final class AuthenticationManager: AuthenticationManagerProtocol {
    
    static let shared = AuthenticationManager()
    
    private init(){}
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        do {
            let authData = try await Auth.auth().createUser(withEmail: email, password: password)
            let dataModelResponse = AuthDataResultModel(user: authData.user)
            return dataModelResponse
        } catch {
            print(error.localizedDescription)
            throw ErrorManager.notificationDenied
        }
    }
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let authUser = Auth.auth().currentUser else {
            throw ErrorManager.noUserWasFound
        }
        return AuthDataResultModel(user: authUser)
    }
    
    func signIn(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func logOut() throws {
        try Auth.auth().signOut()
    }
    
    func deleteUser() async throws {
        guard let user = Auth.auth().currentUser else {
            throw ErrorManager.deleteUser
        }
        
        try await user.delete()
    }
    
    func resetPassword(email: String) async throws {
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func signIn(credential: AuthCredential) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(with: credential)
        return AuthDataResultModel(user: authDataResult.user)
    }
}

// MARK: - Sign In with Google
extension AuthenticationManager {
    
    func signInWithGoogle(idTokens: GoogleSignInResultModel) async throws -> AuthDataResultModel {
        let credential = GoogleAuthProvider.credential(withIDToken: idTokens.idToken, accessToken: idTokens.accessToken)
        return try await signIn(credential: credential)
    }
    
    func reAuthenticateUserWithGoogle(idTokens: GoogleSignInResultModel) async throws {
        guard let user = Auth.auth().currentUser else {
            throw ErrorManager.noUserWasFound
        }
        
        let credentials = GoogleAuthProvider.credential(withIDToken: idTokens.idToken, accessToken: idTokens.accessToken)
        try await user.reauthenticate(with: credentials)
    }
    
}
