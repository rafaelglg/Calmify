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
}

