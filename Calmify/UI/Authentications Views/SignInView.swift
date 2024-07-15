//
//  LoginView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import SwiftUI

@MainActor
struct SignInView: View {
    
    @State var loginVM = LoginViewModel()
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                header
                loginFields
                loginButtons
                register
            }
            .sheet(isPresented: $loginVM.goToSignUpView) {
                SignUpView()
            }
            
            .sheet(isPresented: $loginVM.goToResetPasswordView, content: {
                ResetPasswordView()
            })
            
            .padding(30)
        }
        .clipped()
        //.onTapGesture {
          //  isFocused = false
       // }
    }
}

extension SignInView {
    var header: some View {
        Image(.loginImg)
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
    }
    
    var loginFields: some View {
        VStack(alignment: .leading, spacing: 40) {
            Text("Sign in")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(Constants.backgroundInvert)
            
            TextfieldsLayout(fieldType: .textFieldType, placeholder: "Email", prefix: {Text("@")}, text: $loginVM.email, keyboardType: .emailAddress)
                .focused($isFocused)
            
            TextfieldsLayout(fieldType: .secureFieldType, placeholder: "Password", iconPrefix: {Image(systemName: "lock.fill")}, text: $loginVM.password, keyboardType: .default, isPasswordVisible: $isPasswordVisible, forgotButtonAction: {
                loginVM.goToResetPasswordView = true
            })
            .focused($isFocused)
        }
    }
    
    var loginButtons: some View {
        VStack(spacing: 25) {
            Button {
                Task {
                    do {
                        try await loginVM.signIn()
                        print("success sign-in, go to Home")
                    } catch {
                        if error.localizedDescription == "1009" {
                            print("error interntet")
                        }
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Login")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 25))
            }
            
            Text("Or")
            
            Button {
                Task {
                    do {
                        try await loginVM.signInWithGoogle()
                        print("success sign-in, go to Home")
                    } catch {
                        if error.localizedDescription == "1009" {
                            print("error interntet")
                        }
                        print(error.localizedDescription)
                    }
                }
            } label: {
                HStack {
                    Image(.google)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Login with google")
                    
                }
                .foregroundStyle(Color(hex: 0x00000089))
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity)
                .frame(height: 60)
                .background(Color(hex: 0xffffffff))
                .clipShape(.rect(cornerRadius: 25))
                .shadow(color: Color(hex: 0x00000089).opacity(0.4), radius: 5)
                .padding(.horizontal, 20)
            }
            
        }
        .fullScreenCover(isPresented: $loginVM.isLoggedIn) {
            Home()
        }
        .padding(.top, 40)
    }
    
    var register: some View {
        HStack {
            Text("New to Calmify?")
                .font(.headline)
                .foregroundStyle(Color(.systemGray))
            Button {
                loginVM.goToSignUpView.toggle()
            } label: {
                Text("Sign Up")
                    .font(.headline)
            }
        }
        .padding(.top, 20)
    }
    
}

#Preview {
    SignInView()
}

