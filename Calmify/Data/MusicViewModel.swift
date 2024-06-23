//
//  MusicViewModel.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 22/6/24.
//

import Foundation

@Observable
final class MusicViewModel {
    var music: [MusicModel]
    var selectedMusic: MusicModel?

    
    init() {
        self.music = MusicModel.getMusicModel()
        self.selectedMusic = nil
    }
}
