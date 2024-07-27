//
//  LoginView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 2/7/24.
//

import SwiftUI

struct SignInView: View {
    
    @State var loginVM = LoginViewModel()
    @State private var isLoading: Bool = false
    @State private var isPasswordVisible: Bool = false
    @FocusState private var focusField: Field?
    
    var body: some View {
        ScrollView {
            VStack {
                header
                loginFields
                loginButtons
                register
            }
            .padding(.horizontal ,30)
            
            .sheet(isPresented: $loginVM.goToSignUpView) {
                SignUpView()
            }
            .sheet(isPresented: $loginVM.goToResetPasswordView) {
                ResetPasswordView()
                    .environment(NetworkManager.shared)
            }
            .background(Color.background.onTapGesture {
                focusField = nil
            })
        }
        .clipped()
        .background(Color.background.ignoresSafeArea())
    }
}

extension SignInView {
    var header: some View {
        Image(.loginImg)
            .resizable()
            .scaledToFit()
            .frame(width: 230, height: 230)
    }
    
    var loginFields: some View {
        VStack(alignment: .leading, spacing: 30) {
            Text("Sign in")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .foregroundStyle(Constants.backgroundInvert)
            
            CustomTextfield(iconPrefix: Text("@"), text: $loginVM.email, placeHolder: "Email", textContentType: .emailAddress)
                .keyboardType(.emailAddress)
                .accessibilityLabel(Text(verbatim: "Registration")) // to have email suggestion in keyboard
                .textInputAutocapitalization(.never)
                .submitLabel(.next)
                .onSubmit {
                    focusField = .password
                }
                .focused($focusField,equals: .email)

            CustomSecureTexfield(text: $loginVM.password, showPassword: $isPasswordVisible, showForgetPassword: true) {
                loginVM.goToResetPasswordView = true
            }
            .autocorrectionDisabled(true)
            .submitLabel(.done)
            .onSubmit {
                focusField = nil
            }
            .focused($focusField ,equals: .password)
        }
    }
    
    var loginButtons: some View {
        VStack(spacing: 15) {
            Button {
                Task {
                    do {
                        try await loginVM.signIn()
                        #warning("add spinner when success")
                        print("success sign-in, go to Home")
                    } catch {
                        loginVM.showErrorAlert = true
                        loginVM.errorMessage = error.localizedDescription
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Login")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
                    .frame(width: 180, height: 25)
            }
            .controlSize(.extraLarge)
            .buttonBorderShape(.capsule)
            .buttonStyle(.borderedProminent)
            .alert("Error", isPresented: $loginVM.showErrorAlert) {
                Button {
                    loginVM.showErrorAlert = false
                } label: {
                    Text("Try again")
                }
            } message: {
                Text(loginVM.errorMessage)
            }

            
            Text("Or")
            
            Button {
                Task {
                    do {
                        isLoading = true
                        try await loginVM.signInWithGoogle()
                        print("success sign-in, go to Home")
                    } catch {
                        isLoading = false
                        print(error.localizedDescription)
                    }
                }
            } label: {
                HStack {
                    Image(.google)
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Text("Sign in with Google")
                    
                }
                .foregroundStyle(Color(hex: 0x00000089))
                .fontWeight(.semibold)
                .frame(width: 240, height: 55)
                .background(Color(hex: 0xffffffff))
                .clipShape(.rect(cornerRadius: 30))
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
        .padding(.bottom, 20)
    }
    
}

#Preview {
    SignInView()
}


extension SignInView {
    enum Field: Hashable {
        case email
        case password
    }
}
