//
//  DeleteAccountConfirmationView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 19/7/24.
//

import SwiftUI

@MainActor
struct DeleteAccountConfirmationView: View {
    
    @State private var loginVM = LoginViewModel()
    @State private var goToSignInView: Bool = false
    @State private var loading: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                VStack(spacing: 20) {
                    Spacer()
                    
                    middleText
                    deleteButton
                    Spacer()
                }
                .navigationTitle("Deleting account")
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .ignoresSafeArea()
                .fullScreenCover(isPresented: $goToSignInView) {
                    SignInView()
                }
            }
            
            if loading {
                LoadingView()
            }
        }
    }
}

extension DeleteAccountConfirmationView {
    var middleText: some View {
        Text("To use **Calmify** again you need to create a account")
            .font(.title3)
            .padding(.horizontal, 20)
    }
    
    var deleteButton: some View {
        Button(role: .destructive) {
            Task {
                loading = true
                do {
                    try await loginVM.deleteUser()
                    loginVM.showSuccessAlert = true
                } catch {
                    print(error.localizedDescription)
                    loginVM.showErrorAlert = true
                    loginVM.errorMessage = error.localizedDescription
                }
                loading = false
            }
        } label: {
            Text("Delete account")
                .fontWeight(.semibold)
        }
        .controlSize(.extraLarge)
        .buttonBorderShape(.capsule)
        .buttonStyle(.borderedProminent)
        .alert("Account deleted", isPresented: $loginVM.showSuccessAlert, actions: {
            Button("bye", role: .cancel) {
                loginVM.showSuccessAlert = false
                goToSignInView = true
            }
        }, message: {
            Text("Account deleted successfully")
        })
        .alert("Error deleting account", isPresented: $loginVM.showErrorAlert) {
            if ErrorManager.reauthenticationRequired.errorDescription == loginVM.errorMessage {
                Button(role: .destructive) {
                    loginVM.showErrorAlert = false
                    try? loginVM.logOut()
                    goToSignInView = true
                } label: {
                    Text("Sign out")
                }
            } else {
                Button(role: .cancel) {
                    loginVM.showErrorAlert = false
                } label: {
                    Text("Try again later")
                }
            }
        } message: {
            Text(loginVM.errorMessage)
        }
    }
}

#Preview {
    DeleteAccountConfirmationView()
}
