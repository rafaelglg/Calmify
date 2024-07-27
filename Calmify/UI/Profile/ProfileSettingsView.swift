//
//  ProfileSettingsView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 18/7/24.
//

import SwiftUI

struct ProfileSettingsView: View {
    @State var loginVM = LoginViewModel()
    @State private var isSignOut: Bool = false
    @State private var deleteAccount: Bool = false
    
    var body: some View {
        NavigationStack {
            List {
                signOutButton
                Section("delete") {
                    NavigationLink(destination: DeleteAccountConfirmationView()) {
                        deleteAccountButton
                    }
                }
                appInfo
                legalInfo
            }
            .navigationTitle("Profile")
            .fullScreenCover(isPresented: $loginVM.goToSignInView) {
                SignInView()
            }
        }
    }
}

extension ProfileSettingsView {
    var signOutButton: some View {
        Button {
            isSignOut.toggle()
        } label: {
            Text("Sign out")
        }
        .alert("Sign out", isPresented: $isSignOut) {
            Button("No", role: .cancel) {}
            Button("Yes", role: .destructive) {
                do {
                    try loginVM.logOut()
                } catch {
                    print(error.localizedDescription)
                }
            }
        } message: {
            Text("Are you sure you want to sign out?")
        }
    }
    
    var deleteAccountButton: some View {
        Button {
            deleteAccount = true
        } label: {
            Text("Delete account")
                .foregroundStyle(.red)
        }
    }
    
    var appInfo: some View {
        Section {
            VStack(alignment: .leading) {
                Text("This app was developed by Rafael Loggiodice, using 100% **SwiftUI** and **async await**.")
                    .font(.callout)
            }
        } header: {
            Text("Developer info")
        } footer: {
            Text("This sections is to know the developer identity")
        }
    }
    
    var legalInfo: some View {
        Section {
            HStack {
                Link("Terms of service", destination: URL.safeURL(string: "https://www.google.com"))
                Spacer()
                Image(systemName: "applelogo")
            }
        } footer: {
            Text("legal section")
        }
    }
}



#Preview {
    ProfileSettingsView()
}
