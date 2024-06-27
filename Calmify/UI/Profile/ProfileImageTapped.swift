//
//  ProfileImageTapped.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 25/6/24.
//

import SwiftUI
import PhotosUI

struct ProfileImageTapped: View {
    
    @Environment(\.colorScheme) var colorScheme
    @State private var userVM = UserViewModel.shared
    @State var photoVM = PhotoPickerViewModel.shared
    @State private var buttonTapped: Bool = false
    
    var profileImageAnimation : Namespace.ID
    let dividerColor = #colorLiteral(red: 0.9333333373, green: 0.9333333373, blue: 0.9333333373, alpha: 1)
    
    var body: some View {
        ZStack {
            Constants.backgroundColor
                .opacity(0.5)
                .ignoresSafeArea()
            
            VStack {
                
                userVM.imageProfile
                    .resizable()
                    .scaledToFill()
                    .background(Constants.backgroundColor)
                    .clipShape(Circle())
                    .matchedGeometryEffect(id: "profileImage", in: profileImageAnimation)
                    .frame(width: 300 , height: 300)
                    .padding(.top, 20)
                    .offset(x: 0, y: -130.0)
                
                VStack(spacing: 2.0) {

                    Button {} label: {
                        PhotosPicker(selection: $photoVM.imageSelection, matching: .images) {
                            Text("Change picture")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding()
                                .background(Constants.backgroundColor)
                                .foregroundColor(Constants.backgroundInvert)
                        }
                    }
                    Button {
                        buttonTapped.toggle()
                    } label: {
                        Text("Delete")
                            .fontWeight(.semibold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .foregroundColor(Constants.backgroundInvert)
                    }
                    .alert(isPresented: $buttonTapped) {
                        Alert(title: Text("Are you sure you want to delete this picture?"), message: Text("you can add it after"), primaryButton: .cancel(), secondaryButton: .destructive(Text("delete"), action: {
                            withAnimation(Animation.easeIn(duration: 0.2)){
                                userVM.isImageDeleted = true
                            }
                        }))
                    }
                    .customColorsForButtons(pressedColor: .red, defaultColor: Constants.backgroundColor)
                }
                .background(colorScheme == .light ? Color(uiColor: dividerColor) : Constants.backgroundColor)
                .clipShape(.rect(cornerRadius: 25))
                .padding(.top, -130)
                .frame(width: 300, height: 100)
            }
        }
    }
}

#Preview {
    ProfileImageTapped(profileImageAnimation: Namespace().wrappedValue)
}

extension View {
    func customColorsForButtons(pressedColor: Color, defaultColor: Color ) -> some View {
        buttonStyle(PressableButtonStyle(pressedColor: pressedColor, defaultColor: defaultColor))
    }
}

// MARK: - To make a custom button
struct PressableButtonStyle: ButtonStyle {
    var pressedColor: Color
    var defaultColor: Color

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? pressedColor : defaultColor)
    }
}
