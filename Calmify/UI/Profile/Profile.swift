//
//  Profile.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct Profile: View {
    @State var showSheet: Bool = false
    @Environment (\.colorScheme) var colorScheme
    @State var userVM = UserViewModel.shared
    @State private var imageIsTapped: Bool = false
    @Namespace private var profileImageAnimation
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    
                    bgImage
                    profileImage
                    userName
                    userBio
                    userExtraInfo
                    socialMedia
                    interest
                }
                .navigationTitle(Text(Constants.appTitleName))
                .navigationBarTitleTextColor(.black)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarBackButtonHidden(true)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .sheet(isPresented: $showSheet, content: {
                ModalView()
            })
        }
        .ignoresSafeArea()
        .onChange(of: userVM.isImageDeleted) { _ ,_ in
            if userVM.isImageDeleted {
                userVM.removeProfilePicture()
                imageIsTapped = false
                userVM.resetImageDeletedFlag()
            }
        }
        .overlay {
            if imageIsTapped {
                ProfileImageTapped(profileImageAnimation: profileImageAnimation)
                    .onTapGesture {
                        withAnimation(Animation.easeIn(duration: 0.2)) {
                            imageIsTapped = false
                        }
                    }
            }
        }
    }
}

extension Profile {
    
    var bgImage: some View {
        ZStack() {
            Image(userVM.userData.bgPicture)
                .resizable()
                .scaledToFill()
                .frame(width: 500, height: 80)
        }
    }
    
    var profileImage: some View {
        VStack {
            if !imageIsTapped {
                userVM.imageProfile
                    .resizable()
                    .scaledToFill()
                    .matchedGeometryEffect(id: "profileImage", in: profileImageAnimation)
                    .background(Constants.backgroundColor)
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay {
                        if !userVM.isImageDeleted {
                            Circle()
                                .stroke(Constants.backgroundColor , lineWidth: 3)
                        }
                    }
                    .padding(.top, 20)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            imageIsTapped = true
                        }
                    }
            }
        }
        .frame(width: 100, height: 100)
    }
    
    var userName: some View {
        Text(userVM.userData.name)
            .font(.system(size: 22))
            .fontWeight(.medium)
    }
    
    var userBio: some View {
        Text(userVM.userData.Bio)
            .lineLimit(4)
            .font(.callout)
    }
    
    var userExtraInfo: some View {
        HStack {
            Image(systemName: "mappin.circle")
            Text("Madrid, Spain")
            Image(systemName: "macbook.gen2")
            Text("iOS Developer")
        }
        .font(.subheadline)
        .foregroundStyle(Color(uiColor: .systemGray))
    }
    
    var socialMedia: some View {
        HStack (spacing: 30) {
            Link(destination: URL.safeURL(string: "https://www.apple.com"), label: {
                Label {
                    Text("Message")
                } icon: {
                    Image(systemName: "message")
                }
                .frame(width: 180, height: 50)
                .background(Constants.backgroundColor)
                .foregroundStyle(Constants.backgroundInvert)
                .clipShape(.capsule)
                .shadow(color: colorScheme == .light ? .primary.opacity(0.4) : .clear , radius: 5)
            })
            
            Link(destination: URL.safeURL(string: "https://www.instagram.com/rafaloggiodice"), label: {
                Text("IG")
                    .foregroundStyle(Constants.backgroundInvert)
                    .frame(width: 50, height: 50)
            })
            .background(Constants.backgroundColor)
            .clipShape(.capsule)
            .shadow(color: colorScheme == .light ? .primary.opacity(0.4) : .clear , radius: 5)
        }
    }
    
    var interest: some View {
        VStack {
            VStack(alignment: .leading, spacing: 10) {
                Text("INTERESTS")
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                
                HStack {
                    InterestTag(title: "Climate Change", icon: "leaf.fill", color: Color(uiColor: .systemGray))
                    InterestTag(title: "Weightlifting", icon: "figure.walk", color: Color(uiColor: .systemRed))
                    InterestTag(title: "BBQ", icon: "flame.fill", color: Color(uiColor: .brown))
                }
                
                HStack {
                    InterestTag(title: "Tacos", icon: "fork.knife", color: Color(uiColor: .orange))
                    InterestTag(title: "Stock Market", icon: "chart.line.uptrend.xyaxis", color: Color(uiColor: .systemBlue))
                }
            }
            .padding()
            .padding(.top, 10)
            .padding(.bottom, 40)
            .padding(.horizontal)
            .background(Constants.backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
            .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
            .padding()
        }
    }
}

struct InterestTag: View {
    var title: String
    var icon: String
    var color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .font(.caption)
                .foregroundColor(.white)
            Text(title)
                .font(.caption)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(color.opacity(0.7))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

@MainActor
struct ModalView: View {
    @Environment(\.dismiss) var dismiss
    @State var loginVM = LoginViewModel()
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
                .opacity(0.4)
            
            VStack {
                VStack {
                    Button {
                        do {
                            try loginVM.logOut()
                            print("logout succesfully")
                        } catch {
                            print(error.localizedDescription)
                        }
                    } label: {
                        Text("Logout")
                            .foregroundStyle(Color.backgroundInvert)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.background)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.2) , radius: 8)
                            .padding()
                    }
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundStyle(Color.backgroundInvert)
                            .frame(maxWidth: .infinity)
                            .frame(height: 60)
                            .background(Color.background)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(color: .black.opacity(0.2) , radius: 8)
                            .padding()
                    }
                    
                }
            }
            .presentationDetents([.height(250)])
            .fullScreenCover(isPresented: $loginVM.goToSignInView) {
                SignInView()
            }
        }
    }
}



#Preview {
    Profile()
}
