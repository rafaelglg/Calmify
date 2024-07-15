//
//  ResetPasswordView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 13/7/24.
//

import SwiftUI

@MainActor
struct ResetPasswordView: View {
    
    @State private var email: String = ""
    @State var loginVM = LoginViewModel()
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                header
                resetPasswordField
            }
            .padding(20)
        }
        .clipped()
    }
}

extension ResetPasswordView {
    
    var header: some View {
        Image(.resetPassword)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
    }
    
    var resetPasswordField: some View {
        VStack(spacing: 40) {
            VStack(alignment: .leading, spacing: 20)  {
                Text("Reset password")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Constants.backgroundInvert)
                
                TextfieldsLayout(fieldType: .textFieldType, placeholder: "Email", prefix: {Text("@")}, text: $email, keyboardType: .emailAddress)
            }
            
            Button {
                Task {
                    do {
                        print(email)
                        try await loginVM.resetPassword(for: email)
                    } catch {
                        print(error)
                        print(ErrorManager.noEmailFoundForReset.localizedDescription)
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
        }
        
    }
    
}

#Preview {
    ResetPasswordView()
}
