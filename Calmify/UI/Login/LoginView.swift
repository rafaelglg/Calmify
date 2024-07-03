//
//  LoginView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import SwiftUI

struct LoginView: View {
    
    @State var loginVM = LoginViewModel()
    @State private var isPasswordVisible = false
    
    var body: some View {
        ScrollView {
            VStack {
                header
                loginFields
                loginButtons
                register
            }
            .padding(30)
        }
    }
}

extension LoginView {
    var header: some View {
        Image("login-img")
            .resizable()
            .scaledToFit()
            .frame(width: 250, height: 250)
    }
    
    var loginFields: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Login")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(Constants.backgroundInvert)
            
            HStack {
                Text("@")
                    .foregroundStyle(Color(.systemGray))
                
                VStack {
                    TextField("Email", text: $loginVM.email)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                        .textInputAutocapitalization(.never)
                    Divider()
                }
                //space between "@" and email textfield
                .padding(.leading, 20)
            }
            // space between text login and email textfield
            .padding(.top, 15)
            
            HStack {
                Image(systemName: "lock.fill")
                    .foregroundStyle(Color(.systemGray))
                
                VStack {
                    HStack {
                        if isPasswordVisible {
                            TextField("Password", text: $loginVM.password)
                                .disableAutocorrection(true)
                        } else {
                            SecureField("Password", text: $loginVM.password)
                                .disableAutocorrection(true)
                        }
                        
                        Spacer()
                        
                        Button {
                            isPasswordVisible.toggle()
                        } label: {
                            Image(systemName:  isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .imageScale(.small)
                                .foregroundStyle(.backgroundInvert.opacity(0.5))
                        }
                        .padding(.trailing, 20)
                        Button {
                            // recover password
                        } label: {
                            Text("Forgot?")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(height: 25)
                    Divider()
                }
                .padding(.leading, 20)
            }
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
                //login
            } label: {
                Text("Login with google")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
                    .frame(height: 60)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 25))
            }
        }
        .fullScreenCover(isPresented: $loginVM.isLoggedIn) {
            Home()
        }
        .padding(.top, 30)
    }
    
    var register: some View {
        HStack {
            Text("New to Calmify?")
                .font(.headline)
                .foregroundStyle(Color(.systemGray))
            Button {
                //register view
            } label: {
                Text("Sign Up")
                    .font(.headline)
            }
        }
        .padding(.top, 40)
    }
    
}

#Preview {
    LoginView()
}

