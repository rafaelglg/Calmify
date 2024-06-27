//
//  UserViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 9/6/24.
//

import Foundation
import SwiftUI

@Observable
final class UserViewModel {
    
    static let shared = UserViewModel()
    var userData: UserModel
    var isImageDeleted: Bool = false
    
    init() {
        self.userData = UserModel.getUserModel()
    }
    
    var imageProfile: Image {
        if userData.profilePicture.isEmpty { //Image deleted
            return Image(systemName: "person.circle.fill")
        } else if let data = Data(base64Encoded: userData.profilePicture),
                  let uiImage = UIImage(data: data) { // when the picture is selected by photo picker
            return Image(uiImage: uiImage)
        } else {
            return Image(userData.profilePicture) // default image
        }
    }
    
    func updateProfilePicture(with base64String: String) {
        userData.profilePicture = base64String
    }
    
    func removeProfilePicture() {
        isImageDeleted = true
        userData.profilePicture = ""
    }
    
    func resetImageDeletedFlag() {
        isImageDeleted = false
    }
}
