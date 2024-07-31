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
    @State private var isLoading: Bool = false
    @State private var isPasswordVisible: Bool = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    header
                    signUpText
                    signUpFields
                    button
                }
                .padding(.horizontal, 30)
                .onAppear {
                    focusField = .fullName
                }
                .background(Color.background.onTapGesture {
                    focusField = nil
                })
            }
            
            .fullScreenCover(isPresented: $loginVM.goToHomeView){
                Home()
            }
            .clipped() //Clips the view within the scrollView
            .background(Color.background.ignoresSafeArea())
            
            if isLoading {
                LoadingView()
            }
        }
    }
}

extension SignUpView {
    var header: some View {
        Image(.signUp)
            .resizable()
            .scaledToFill()
            .frame(width: 250, height: 210)
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
            
            CustomTextfield(iconPrefix: Image(systemName: "person.fill"), text: $loginVM.name, placeHolder: "Full name", textContentType: .name)
                .focused($focusField, equals: .fullName)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .email
                }
                .onChange(of: loginVM.name) {
                    loginVM.buttonEnableForSignUp()
                }
            
            CustomTextfield(iconPrefix: Text("@"), text: $loginVM.email, placeHolder: "Email", textContentType: .emailAddress)
                .focused($focusField, equals: .email)
                .keyboardType(.emailAddress)
                .accessibilityLabel(Text(verbatim: "Registration")) // to have email suggestion in keyboard
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .password
                }
                .onChange(of: loginVM.email) {
                    loginVM.buttonEnableForSignUp()
                }
            
            CustomSecureTexfield(text: $loginVM.password, showPassword: $isPasswordVisible, showForgetPassword: false, forgetPasswordAction: nil)
                .focused($focusField, equals: .password)
                .submitLabel(.done)
                .onSubmit {
                    focusField = nil
                }
                .onChange(of: loginVM.password) {
                    loginVM.buttonEnableForSignUp()
                }
        }
        .padding(.top, 10)
    }
    
    var button: some View {
        VStack {
            Button {
                Task {
                    isLoading = true
                    do {
                        try await loginVM.signUp()
                        print("cuenta creada")
                        loginVM.goToHomeView.toggle()
                    } catch {
                        loginVM.showErrorAlert = true
                        loginVM.errorMessage = error.localizedDescription
                        print(error.localizedDescription)
                    }
                    isLoading = false

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
            .alert("Error", isPresented: $loginVM.showErrorAlert) {
                Button {
                    loginVM.showErrorAlert = false
                } label: {
                    Text("Try again")
                }
            } message: {
                Text(loginVM.errorMessage)
            }
            
        }
        .padding(.top, 30)
        .padding(.bottom, 30)
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
