//
//  GoogleSignInResultModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 14/7/24.
//

import Foundation

struct GoogleSignInResultModel {
    let idToken: String
    let accessToken: String
    let name: String?
    let email: String?
}
