//
//  ResetPasswordView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 13/7/24.
//

import SwiftUI

struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @StateObject var loginVM = LoginViewModel()
    @State private var showAlert: Bool = false
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String?
    @FocusState private var focusField: Field?
    @Environment(\.dismiss) private var dismiss
    @Environment(NetworkManager.self) private var network
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                header
                resetPasswordField
            }
            .padding(20)
            .background(Color.background.onTapGesture {
                focusField = nil
            })
        }
        .clipped()
        .background(Color.background.ignoresSafeArea())
    }
}

extension ResetPasswordView {
    
    var header: some View {
        VStack {
            Image(.resetPassword)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250)
        }
    }
    
    var resetPasswordField: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 20)  {
                Text("Reset password")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Constants.backgroundInvert)
                
                CustomTextfield(iconPrefix: Text("@"), text: $email, placeHolder: "Email", textContentType: .emailAddress)
                    .keyboardType(.emailAddress)
                    .accessibilityLabel(Text(verbatim: "Registration")) // to have email suggestion in keyboard
                    .focused($focusField, equals: .email )
            }
            
            Button {
                Task {
                    do {
                        print(email)
                        try await loginVM.resetPassword(for: email)
                        print(email + " enviado")
                        showAlert = true
                    } catch {
                        showErrorAlert = true
                        errorMessage = error.localizedDescription
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("send")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(width: 180, height: 25)
            }
            .controlSize(.extraLarge)
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .alert("Email sent", isPresented: $showAlert, actions: {
                Button {
                    showAlert = false
                    dismiss()
                }  label: {
                    Text("Dismiss")
                }
            }, message: {
                Text("Check your email to reset your password.")
            })
            
            .alert(network.isConnected ? "Error" : "No internet connection", isPresented: $showErrorAlert) {
                Button("Cancel", role: .cancel) {
                    showErrorAlert = false
                }
            } message: {
                Text(errorMessage ?? "")
            }
        }
    }
}

#Preview {
    ResetPasswordView()
        .environment(NetworkManager.shared)
}

extension ResetPasswordView {
    enum Field: Hashable {
        case email
    }
}
