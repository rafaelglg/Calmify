//
//  UserModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 9/6/24.
//

import Foundation

struct UserModel: Identifiable {
    let id = UUID()
    var name: String
    var profilePicture: String
    let Bio: String
    let bgPicture: String
    
    static func getUserModel() -> UserModel {
        return .init(name: "Rafael Loggiodice", profilePicture: "profilePic", Bio: """
                     Esta es la Bio
                     que tiene 4 lineas
                     maximas
                     """, bgPicture: "bgimage_Profile")
    }
}
