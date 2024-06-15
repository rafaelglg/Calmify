//
//  Breather.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 8/6/24.
//

import SwiftUI

struct Breather: View {
    @Binding var selectedTab: Int
    @State var user = UserViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                header
                mainContent
                
                ToolBar(user: user, selectedTab: $selectedTab)
            }
            .navigationTitle("Calmify")
            .navigationBarTitleDisplayMode(.inline)

        }
    }
}

#Preview {
    Breather(selectedTab: .constant(0))
}

extension Breather {
    
    var header: some View {
        VStack {
            Text("Welcome!")
                .font(.largeTitle)
                .bold()
                .frame(maxWidth: .infinity, alignment: .topLeading)
        }
        .padding()
    }
    
    var mainContent: some View {
        VStack {
            HStack{
                Text("Take 1 minute to **breathe** ")
            }
            .font(.title2)
            
            Image("meditationBreatheView")
                .resizable()
                .frame(width: 350, height: 350)
                .scaledToFit()
            
            NavigationLink {
                BreathingView()
            } label: {
                Text("Breathe")
                    .frame(width: 150, height: 50)
                    .foregroundStyle(.white)
                    .background(Color.cyan)
                    .clipShape(.buttonBorder)
                    .shadow(color: .cyan.opacity(0.7), radius: 8)
            }.padding()
        }
        .padding(.top, 60)
    }
    
}

struct ToolBar: View {
    
    @Bindable var user: UserViewModel
    @Binding var selectedTab: Int
    
    var body: some View {
        VStack {
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    selectedTab = 2
                }, label: {
                    Image(user.userData.profilePicture)
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke()
                                .stroke(lineWidth: 1)
                                .padding(-3)
                        }
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(uiColor: .systemGray))
                })
            }
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                }, label: {
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(uiColor: .systemGray))
                    
                })
            }
        }
        
    }
}
