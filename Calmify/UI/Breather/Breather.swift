//
//  Breather.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 8/6/24.
//

import SwiftUI

struct Breather: View {
    @Binding var selectedTab: Int
    @State private var user = UserViewModel.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                header
                mainContent
                
                BreatherToolBar(user: user, selectedTab: $selectedTab)
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
        Text("Welcome!")
            .font(.largeTitle)
            .bold()
            .frame(maxWidth: .infinity, alignment: .topLeading)
            .padding()
    }
    
    var mainContent: some View {
        VStack {
            HStack{
                Text("Take 1 minute to **breathe** ")
            }
            .font(.title2)
            
            Image("Breathing-home")
                .resizable()
                .frame(width: 350, height: 350)
                .scaledToFit()
            
            NavigationLink {
                BreathingView()
            } label: {
                Text("Start Breathing")
                    .frame(width: 190, height: 65)
                    .foregroundStyle(Constants.backgroundInvert)
                    .background(Constants.backgroundColor)
                    .clipShape(.rect(cornerRadius: 25))
                    .shadow(color: colorScheme == .light ? .backgroundInvert.opacity(0.4) : .clear, radius: 8)
            }.padding()
        }
        .padding(.top, 30)
    }
    
}

struct BreatherToolBar: View {
    
    @Bindable var user: UserViewModel
    @Binding var selectedTab: Int
    @State private var isNotificationTapped: Bool = false
    @State private var sheetIsTapped: Bool = false
    
    var body: some View {
        VStack {
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    selectedTab = 2
                } label: {
                    user.imageProfile
                        .resizable()
                        .frame(width: 35, height: 35)
                        .clipShape(.circle)
                        .overlay {
                            Circle()
                                .stroke()
                                .stroke(lineWidth: 1)
                                .padding(-3)
                        }
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                
                Menu {
                    Button {
                        
                    } label: {
                        Label("Acción 1", systemImage: "bell")
                    }
                } label: {
                    Image(systemName: "ellipsis.circle")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if NotificationManager.shared.isNotification {
                        isNotificationTapped = true
                        NotificationManager.shared.scheduleNotification(trigger: .time, title: "Have 5 minutes to breathe", body: "Use Breather whenever you want")
                    }
                } label: {
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundStyle(Color(uiColor: .systemGray))
                }.alert(isPresented: $isNotificationTapped) {
                    
                    Alert(title: Text("Notification active"), message: Text("You will have every day at 9 AM a notification to remember to take a moment for yourself."), primaryButton: .default(Text("OK")), secondaryButton: .cancel {
                        NotificationManager.shared.removeAll()
                    })
                }
            }
        }
    }
}
