//
//  UserManager.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 30/7/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DataBaseUser: Codable {
    let uid: String
    var name: String?
    let email: String?
    let photoURL: String?
    let dateCreated: Date?
    
    init(auth: AuthDataResultModel) {
        self.uid = auth.uid
        self.name = auth.name
        self.email = auth.email
        self.photoURL = auth.photoURL
        self.dateCreated = Date()
    }
    
    enum CodingKeys: String ,CodingKey {
        case uid = "uid"
        case name = "name"
        case email = "email"
        case photoURL = "photo_URL"
        case dateCreated = "date_created"
    }
    
    mutating func addName(name: String) {
        self.name = name
    }
}

final class UserManager {
    
    static let shared = UserManager() // singleton
    private let userCollection = Firestore.firestore().collection("users")
    
    private init(){}
    
    private func userDocument(userID: String) -> DocumentReference {
        userCollection.document(userID)
    }
    
    func createNewUser(user: DataBaseUser) async throws {
        try userDocument(userID: user.uid).setData(from: user, merge: false)
    }
    
    func getUser(userID: String) async throws -> DataBaseUser {
        try await userDocument(userID: userID).getDocument(as: DataBaseUser.self)
    }
}
