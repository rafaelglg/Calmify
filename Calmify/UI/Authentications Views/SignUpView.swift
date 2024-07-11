//
//  SignUpView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 3/7/24.
//

import SwiftUI

struct SignUpView: View {
    
    @State private var loginVM = LoginViewModel()
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                header
                signUpText
                signUpFields
                button
            }
            .padding(.horizontal, 30)
        }
        .clipped()
        .onTapGesture {
            isFocused = false
        }
    }
}

extension SignUpView {
    var header: some View {
        Image("signUp")
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 250)
    }
    
    var signUpText: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Welcome to Calmify")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundStyle(Constants.backgroundInvert)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    var signUpFields: some View {
        VStack(spacing: 20) {
                        
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
                    .padding(.horizontal, 20)
            }
            
              HStack {
                  Divider()
                      .frame(width: 100, height: 1)
                      .background(Color(.systemGray5))
                  Text("OR")
                      .font(.headline)
                      .foregroundStyle(Color(.systemGray))
                      .padding(.horizontal)
                  Divider()
                      .frame(width: 100, height: 1)
                      .background(Color(.systemGray5))
              }
              .frame(maxWidth: .infinity)
              .frame(width: 300, height: 30)

              .padding(.horizontal)

            
            VStack(spacing: 30) {
                
                TextfieldsLayout(fieldType: .textFieldType, placeholder: "Full name", prefix: {Image(systemName: "person.fill")}, text: $loginVM.name, keyboardType: .namePhonePad)
                    .focused($isFocused)
                
                TextfieldsLayout(fieldType: .textFieldType, placeholder: "Email", prefix: {Text("@")}, text: $loginVM.email, keyboardType: .emailAddress)
                    .focused($isFocused)
                
                TextfieldsLayout(fieldType: .secureFieldType, placeholder: "Password", prefix: {Image(systemName: "lock.fill")}, text: $loginVM.password, keyboardType: .namePhonePad, isPasswordVisible: $isPasswordVisible)
                    .focused($isFocused)
                
                TextfieldsLayout(fieldType: .numberField, placeholder: "Mobile", prefix: {Image(systemName: "phone.fill")}, text: $loginVM.phoneNumber, keyboardType: .phonePad)
                    .focused($isFocused)
            }
        }
        .padding(.top, 10)
    }
    
    var button: some View {
        VStack {
            Button {
                Task {
                    do {
                        try await loginVM.signUp()
                        print("cuenta creada")
                        loginVM.goToHomeView.toggle()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Enter")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(width: 200 ,height: 50)
                    .background(.blue)
                    .clipShape(.rect(cornerRadius: 25))
                
            }
        }
        .fullScreenCover(isPresented: $loginVM.goToHomeView){
            Home()
        }
        .padding(.top, 30)
    }
}

#Preview {
    SignUpView()
}
