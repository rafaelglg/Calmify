//
//  SignUpView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 3/7/24.
//

import SwiftUI

@MainActor
struct SignUpView: View {
    
    @State private var loginVM = LoginViewModel()
    @State private var isPasswordVisible: Bool = false
    @FocusState private var focusField: Field?
    @State private var keyboardHeight: CGFloat = 0
    
    
    var body: some View {
        ScrollView {
            VStack {
                header
                signUpText
                signUpFields
                button
            }
            .onTapGesture {
                focusField = nil
            }
            .padding(.horizontal, 30)
            .onAppear {
                focusField = .fullName
            }
        }
        .clipped() //Clips the view within the scrollView
    }
}

extension SignUpView {
    var header: some View {
        Image(.signUp)
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
        VStack(spacing: 30) {
            
            TextfieldsLayout(fieldType: .textFieldType, placeholder: "Full name", prefix: {Image(systemName: "person.fill")}, text: $loginVM.name, keyboardType: .default)
                .textContentType(.name)
                .focused($focusField, equals: .fullName)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .email
                }
                .onChange(of: loginVM.name) {
                    loginVM.buttonEnableForSignUp()
                }
            
            TextfieldsLayout(fieldType: .textFieldType, placeholder: "Email", prefix: {Text("@")}, text: $loginVM.email, keyboardType: .emailAddress)
                .textContentType(.emailAddress)
                .focused($focusField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .password
                }
                .onChange(of: loginVM.email) {
                    loginVM.buttonEnableForSignUp()
                }
            
            TextfieldsLayout(fieldType: .secureFieldType, placeholder: "Password", iconPrefix: {Image(systemName: "lock.fill")}, text: $loginVM.password, keyboardType: .default, isPasswordVisible: $isPasswordVisible, forgotButtonEnable: false)
                .textContentType(.password)
                .focused($focusField, equals: .password)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .phoneNumber
                }
                .onChange(of: loginVM.password) {
                    loginVM.buttonEnableForSignUp()
                }
            
            TextfieldsLayout(fieldType: .numberField, placeholder: "Mobile", prefix: {Image(systemName: "phone.fill")}, text: $loginVM.phoneNumber, keyboardType: .phonePad)
                .focused($focusField, equals: .phoneNumber)
                .submitLabel(.done)
                .onSubmit {
                    focusField = nil
                }
                .onChange(of: loginVM.phoneNumber) {
                    loginVM.buttonEnableForSignUp()
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
                    .background(loginVM.buttonIsEnable ? .blue : .gray)
                    .clipShape(.rect(cornerRadius: 25))
                
            }
            .disabled(!loginVM.buttonIsEnable)
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

extension SignUpView {
    enum Field: Hashable {
        case fullName
        case email
        case password
        case phoneNumber
    }
}
