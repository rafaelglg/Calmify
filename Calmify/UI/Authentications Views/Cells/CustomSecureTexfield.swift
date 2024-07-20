//
//  CustomSecureTexfield.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 20/7/24.
//

import SwiftUI

struct CustomSecureTexfield: View {
    @Binding var text: String
    @Binding var showPassword: Bool
    let showForgetPassword: Bool
    let forgetPasswordAction: (() -> Void)?

    var body: some View {
        HStack {
            Image(systemName: "lock.fill")
                .foregroundStyle(Color(.systemGray))
                .padding(.trailing, 20)
            VStack {
                HStack {
                    if showPassword {
                        TextField("Password", text: $text)
                    } else {
                        SecureField("Password", text: $text)
                            .textContentType(.password)
                    }
                    Spacer()
                    Button {
                        showPassword.toggle()
                    } label: {
                        Image(systemName: showPassword ? "eye.slash.fill" : "eye.fill")
                            .imageScale(.small)
                            .foregroundStyle(.backgroundInvert.opacity(0.5))
                            .frame(height: 25)
                    }
                    
                    if showForgetPassword, let forgetPasswordAction = forgetPasswordAction {
                        Button {
                                 forgetPasswordAction()
                            
                        } label: {
                            Text("Forgot?")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                        .padding(.leading, 10)
                    }
                    
                    Spacer()
                }
                Divider()
                    .background(Constants.backgroundInvert)
            }
        }
    }
}

#Preview {
    CustomSecureTexfield(text: .constant("prueba"), showPassword: .constant(.random()), showForgetPassword: false, forgetPasswordAction:{})
}
