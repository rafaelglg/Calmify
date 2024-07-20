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
            iconPrefix: { AnyView(Text("")) },
            text: .constant("hola"),
            keyboardType: .emailAddress,
            isPasswordVisible: .constant(false)
        )
    }
    
    static var previewPassword: TextfieldsLayout {
        TextfieldsLayout(
            fieldType: .secureFieldType,
            placeholder: "hola",
            iconPrefix: { AnyView(Image(systemName: "lock.fill")) },
            text: .constant("hola"),
            keyboardType: .default,
            isPasswordVisible: .constant(true)
        )
    }
}

extension Color {
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 8) & 0xFF) / 255.0
        let blueValue = Double(rgb & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
    
    init(hex: UInt32) {
        let red = Double((hex >> 24) & 0xff) / 255.0
        let green = Double((hex >> 16) & 0xff) / 255.0
        let blue = Double((hex >> 8) & 0xff) / 255.0
        let alpha = Double(hex & 0xff) / 255.0

        self.init(red: red, green: green, blue: blue, opacity: alpha)
    }
}
