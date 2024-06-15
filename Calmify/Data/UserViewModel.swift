//
//  UserViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 9/6/24.
//

import SwiftUI

@Observable
class UserViewModel {
    let userData: UserModel
    
    init() {
        self.userData = UserModel.getUserModel()
    }
}
