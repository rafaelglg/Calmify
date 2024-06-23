//
//  MusicModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 22/6/24.
//

import Foundation

struct MusicModel: Identifiable {
    let id = UUID().uuidString
    let name: String
    let artist: String
    
    static func getMusicModel() -> [MusicModel] {
        return [
            MusicModel(name: "Healing meditation", artist: "White_Records"),
            MusicModel(name: "Deep relaxation", artist: "White_Records")
        ]
    }
}
