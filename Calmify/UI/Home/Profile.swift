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
    @State var userVM = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    
                    bgImage
                    profileImage
                        .padding(.top, 20)
                    userName
                    userBio
                    userExtraInfo
                    socialMedia
                        .padding()
                    
                    interest
                        .background(Constants.backgroundColor)
                        .clipShape(RoundedRectangle(cornerRadius: 30, style: .circular))
                        .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                        .padding()
                }
                .navigationTitle(Text(Constants.appTitleName))
                .navigationBarTitleTextColor(colorScheme == .dark ? .white : .black)
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
                ZStack {
                    Color.init(uiColor: .systemTeal).ignoresSafeArea()
                    
                    VStack {
                        Button {
                            
                        } label: {
                            Text("Edit profile")
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                        
                        Button {
                            showSheet = false
                        } label: {
                            Text("Cancel")
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)               .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .shadow(radius: 5)
                        }
                    }
                    .padding(50)
                    .presentationDetents([.height(250)])
                }
            })
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
    
    var userName: some View {
        Text(userVM.userData.name)
            .font(.system(size: 22))
            .fontWeight(.medium)
            .padding(.bottom, 7)
            .padding(.top, 10)
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
        .padding(.top,3)
    }
    
    var profileImage: some View {
        Image(userVM.userData.profilePicture)
            .resizable()
            .scaledToFill()
            .clipShape(.circle)
            .frame(width: 100, height: 100)
            .overlay {
                Circle()
                    .stroke(.white, lineWidth: 3)
            }
            .onTapGesture {
            }
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

#Preview {
    Profile()
}
