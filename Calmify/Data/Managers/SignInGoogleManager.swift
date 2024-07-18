//
//  SignInGoogleManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 15/7/24.
//

import Foundation
import GoogleSignIn
import GoogleSignInSwift

protocol SignInGoogleManagerProtocol {
    func signIn() async throws -> GoogleSignInResultModel
}

final class SignInGoogleManager: SignInGoogleManagerProtocol {
    
    let authManager: AuthenticationManagerProtocol = AuthenticationManager.shared
    
    @MainActor
    func signIn() async throws -> GoogleSignInResultModel {
        guard let topVC = Utils.getTopViewController() else {
            throw ErrorManager.notFindTopVC
        }
        
        let gidSignInResult = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResult.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        let accessToken = gidSignInResult.user.accessToken.tokenString
        let name = gidSignInResult.user.profile?.name
        let email = gidSignInResult.user.profile?.email
        
        let tokens = GoogleSignInResultModel(idToken: idToken, accessToken: accessToken, name: name, email: email)
        return tokens
    }
}
