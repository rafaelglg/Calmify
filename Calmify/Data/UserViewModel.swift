//
//  UserViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 9/6/24.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var userData: UserModel
    
    init() {
        self.userData = UserModel.getUserModel()
    }
}
