//
//  Home.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct Home: View {
    @State var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            Breather(selectedTab: $selectedTab)
                .tabItem {
                    Image(systemName: "leaf")
                    Text("Breathe")
                }
                .tag(0)
            CalendarView()
                .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                .tag(1)
            Profile()
                .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
                .tag(2)
        }
        .onAppear {
            UNUserNotificationCenter.current().setBadgeCount(0)
            NotificationManager.shared.RemoveDeliveredNotifications()
        }
    }
}

#Preview {
    Home()
}
