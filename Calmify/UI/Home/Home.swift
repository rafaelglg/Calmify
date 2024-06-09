//
//  Home.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct Home: View {
    var body: some View {
        
            TabView {
                Breather()
                    .font(.system(size: 40))
                    .bold()
                    .tabItem {
                    Image(systemName: "leaf")
                    Text("Breathe")
                }
                CalendarView()
                    .tabItem {
                    Image(systemName: "calendar")
                    Text("Calendar")
                }
                Profile()
                    .tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
            }
        }
    }
}

#Preview {
    Home()
}
