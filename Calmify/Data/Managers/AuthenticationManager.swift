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
    func logOut() throws
    @discardableResult
    func signIn(email: String, password: String) async throws -> AuthDataResultModel
    
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
            throw URLError.init(.userAuthenticationRequired)
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
    
    
    
}
