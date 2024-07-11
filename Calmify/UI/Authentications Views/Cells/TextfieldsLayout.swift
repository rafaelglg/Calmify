//
//  TextfieldsLayout.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 3/7/24.
//

import SwiftUI
import Combine

enum FieldType {
    case textFieldType
    case secureFieldType
    case numberField
}

struct TextfieldsLayout<T: View>: View {
    
    let fieldType: FieldType
    let placeholder: String
    let prefix: () -> T
    @Binding var text: String
    let keyboardType: UIKeyboardType
    @Binding var isPasswordVisible: Bool
    @Environment(\.colorScheme) var colorScheme
    
    init(fieldType: FieldType, placeholder: String, prefix: @escaping () -> T, text: Binding<String>, keyboardType: UIKeyboardType, isPasswordVisible: Binding<Bool>) {
        self.fieldType = fieldType
        self.placeholder = placeholder
        self.prefix = prefix
        self._text = text
        self.keyboardType = keyboardType
        self._isPasswordVisible = isPasswordVisible
    }
    
    init(fieldType: FieldType, placeholder: String, prefix: @escaping () -> T, text: Binding<String>, keyboardType: UIKeyboardType) {
        self.fieldType = fieldType
        self.placeholder = placeholder
        self.prefix = prefix
        self._text = text
        self.keyboardType = keyboardType
        self._isPasswordVisible = .constant(false)
    }
    
    var body: some View {
        HStack {
            prefix()
                .foregroundStyle(Color(.systemGray))
            VStack {
                HStack {
                    if fieldType == .textFieldType {
                        TextField(placeholder, text: $text)
                            .keyboardType(keyboardType)
                            .textInputAutocapitalization(.never)
                    } else if fieldType == .numberField {
                        
                        TextField(placeholder, text: $text)
                            .keyboardType(.numberPad)
                            .onReceive(Just(text)) { newValue in
                                let filtered = newValue.filter { "0123456789".contains($0) }
                                if filtered != newValue {
                                    self.text = filtered
                                }
                            }
                        
                    } else {
                        if isPasswordVisible {
                            TextField(placeholder, text: $text)
                                .keyboardType(keyboardType)
                                .disableAutocorrection(true)
                        } else {
                            SecureField(placeholder, text: $text)
                                .keyboardType(keyboardType)
                                .disableAutocorrection(true)
                        }
                        HStack {
                            Button {
                                isPasswordVisible.toggle()
                            } label: {
                                Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                    .imageScale(.small)
                                    .foregroundStyle(.backgroundInvert.opacity(0.5))
                                    .frame(height: 25)
                            }
                            .padding(.trailing, 20)
                            Button {
                                isPasswordVisible.toggle()
                                print("forgot pressed")
                            } label: {
                                Text("Forgot?")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }
                        }
                    }
                }
                Divider()
                    .background(Constants.backgroundInvert)
            }
            .padding(.leading, 20)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    TextfieldsLayout(fieldType: .textFieldType, placeholder: "Email", prefix: {Text("@")}, text: .constant("hola"), keyboardType: .emailAddress)
}

#Preview(traits: .sizeThatFitsLayout) {
    TextfieldsLayout(fieldType: .secureFieldType, placeholder: "Password", prefix: {Image(systemName: "lock.fill")}, text: .constant("hola"), keyboardType: .emailAddress, isPasswordVisible: .constant(false))
}

#Preview(traits: .sizeThatFitsLayout) {
    TextfieldsLayout(fieldType: .numberField, placeholder: "Number", prefix: {Image(systemName: "applelogo")}, text: .constant(""), keyboardType: .emailAddress)
}

