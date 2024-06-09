//
//  Profile.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct Profile: View {
    @State private var selection = "Randomize Profile"
    let randomProfile = ["Edit","Randomize Profile"]

    @ObservedObject var userVM = UserViewModel()
    
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
                    
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Randomize", selection: $selection) {
                            ForEach(randomProfile, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.wheel)
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
        }
    }
    
    var bgImage: some View {
        ZStack() {
            Image(userVM.userData.bgPicture)
                .resizable()
                .scaledToFill()
                .frame(width: 500, height: 100)
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
            .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/)
            .overlay(content: {
                Circle()
                    .stroke(.white, lineWidth: 3)
            })
    }
    
    var socialMedia: some View {
        HStack (spacing: 30) {
            Button(action: {
                print("boton message")
            }, label: {
                Label(
                    title: {                             Text("Message")
                    },
                    icon: {
                        Image(systemName: "message")
                    })
                .frame(width: 180, height: 50)
                .background(Color(uiColor: .black))
                .foregroundStyle(.white)
                .clipShape(.capsule)
            })
            
            Button(action: {
                print("boton instagram")
            }, label: {
                Text("IG")
                    .foregroundStyle(.white)
                    .frame(width: 50, height: 50)
                
            })
            .background(Color(uiColor: .black))
            .clipShape(.capsule)
            
        }
    }
    
}


#Preview {
    Profile()
}
