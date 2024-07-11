//
//  InitialHome.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 5/6/24.
//

import SwiftUI

struct CoordinatorView: View {
    @State var goToHomeView: Bool = false
    @State var animate: Bool = false
    @State var showSignInView: Bool = false
    
    var body: some View {
        Group {
            if goToHomeView {
                if showSignInView {
                    SignInView()
                } else {
                    Home()
                }
            } else {
                onBoarding(goToHomeView: $goToHomeView, animate: $animate)
            }
        }
        .onAppear {
                let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
                print(authUser as Any)
                showSignInView = authUser == nil
        }
    }
}

#Preview {
    CoordinatorView()
}
