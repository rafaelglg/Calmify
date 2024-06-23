//
//  MusicView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 22/6/24.
//

import SwiftUI

struct MusicView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var playIsTapped: Bool = false
    @State private var backRewind: Bool = false
    @State private var musicVM = MusicViewModel()
    @State private var selectedSound: Bool = false
    
    var body: some View {
        VStack {
            Menu {
                ForEach(musicVM.music) { musicResponse in
                    //MARK: Choose music button
                    Button {
                        selectedSound = true
                        if selectedSound {
                            SoundManager.shared.getSound(forMusic: musicResponse.name)
                            SoundManager.shared.playSound()
                            musicVM.selectedMusic = musicResponse
                            selectedSound = false
                            playIsTapped = true
                        }
                    } label: {
                        Text("\(musicResponse.name)")
                        if musicVM.selectedMusic?.id == musicResponse.id {
                            getCheckMark()
                        }
                    }
                }
            } label: {
                Text(Constants.chooseMusic)
                    .foregroundStyle(Constants.backgroundInvert)
                    .frame(width: 230, height: 60)
                    .background(Constants.backgroundColor)
                    .clipShape(.rect(cornerRadius: 25))
                    .shadow(
                        color: colorScheme == .light ? Constants.backgroundInvert.opacity(0.4) : .clear , radius: 5)
            }
        }
        .padding(.top, 20)
        
        //MARK: Rewind Button
        HStack {
            Group {
                Button {
                    backRewind.toggle()
                    SoundManager.shared.rewindSound()
                    SoundManager.shared.playSound()
                    playIsTapped = true
                } label: {
                    Image(systemName: "backward.fill")
                        .frame(width: 100, height: 40)
                        .foregroundStyle(Constants.backgroundInvert)
                }
                
                //MARK: Play Button
                Button {
                    playIsTapped.toggle()
                    if playIsTapped {
                        SoundManager.shared.playSound()
                    } else {
                        SoundManager.shared.stopPlayingSound()
                    }
                } label: {
                    Image(systemName: playIsTapped ? "pause.fill" : "play.circle.fill")
                        .frame(width: 100, height: 40)
                        .foregroundStyle(Constants.backgroundInvert)
                }
            }
            .frame(width: 80, height: 40)
            .background(Constants.backgroundColor)
            .clipShape(.rect(cornerRadius: 25))
            .shadow(radius: 5)
        }
        /****When the view dissapears, reset the button and stop music. */
        .onDisappear{
            SoundManager.shared.stopPlayingSound()
            playIsTapped = false
            
        }
        .padding()
    }
    //MARK: -
    func getCheckMark() -> Image {
        return Image(systemName: "checkmark")
    }
}

#Preview {
    MusicView()
}
