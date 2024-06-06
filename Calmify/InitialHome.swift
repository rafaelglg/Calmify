//
//  InitialHome.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 5/6/24.
//

import SwiftUI

struct InitialHome: View {
    @State var goToHomeView: Bool = false
    @State var animate: Bool = false
    var body: some View {
        if goToHomeView {
            Home()
        } else {
            InitialHomeView(goToHomeView: $goToHomeView, animate: $animate)
        }
    }
}

struct Home: View {
    var body: some View {
        
        NavigationStack {
            Text("Rafa")
                .font(.system(size: 20)).bold()
            TabView {
                Text("Home").tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
                Text("tab2").tabItem {
                    Image(systemName: "heart")
                    Text("Favorite")
                }
                Text("tab3").tabItem {
                    Image(systemName: "person.circle.fill")
                    Text("Profile")
                }
            }
        }.padding(.top)
    }
}

#Preview {
    InitialHome()
}
