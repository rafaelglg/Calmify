//
//  Extensions.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 21/6/24.
//

import SwiftUI

extension URL {
    static func safeURL(string: String) -> URL {
        guard let url = URL(string: string) else {
            return URL(string: "https://www.apple.com/")!
        }
        return url
    }
}

extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
    
    func customColorsForButtons(pressedColor: Color, defaultColor: Color ) -> some View {
        buttonStyle(PressableButtonStyle(pressedColor: pressedColor, defaultColor: defaultColor))
    }
}

extension TextfieldsLayout where T == AnyView {
    static var previewEmail: TextfieldsLayout {
        TextfieldsLayout(
            fieldType: .textFieldType,
            placeholder: "Email",
            prefix: { AnyView(Text("")) },
            text: .constant("hola"),
            keyboardType: .emailAddress,
            isPasswordVisible: .constant(false)
        )
    }
    
    static var previewPassword: TextfieldsLayout {
        TextfieldsLayout(
            fieldType: .secureFieldType,
            placeholder: "hola",
            prefix: { AnyView(Image(systemName: "lock.fill")) },
            text: .constant("hola"),
            keyboardType: .default,
            isPasswordVisible: .constant(true)
        )
    }
}
