//
//  Constants.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 20/6/24.
//

import Foundation
import SwiftUI

class Constants {
    static let appTitleName: String = "Calmify"
    static let backgroundColor: Color = Color("Background")
    static let backgroundInvert: Color = Color("BackgroundInvert")

}

extension URL {
    static func safeURL(string: String) -> URL {
        guard let url = URL(string: string) else {
            return URL(string: "https://www.apple.com/")!
        }
        return url
    }
}

extension View {
    @available(iOS 14, *)
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
