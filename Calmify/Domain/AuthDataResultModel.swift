//
//  AuthDataResultModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoURL: String?
    let name: String
    let phoneNumber: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoURL = user.photoURL?.absoluteString
        self.name = user.displayName ?? "No name"
        self.phoneNumber = user.phoneNumber
    }
}
