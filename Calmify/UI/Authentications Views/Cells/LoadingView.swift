//
//  LoadingView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 15/7/24.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.white.opacity(0.3)
                .ignoresSafeArea()
            ProgressView("Loading...")
                .font(.caption)
                .progressViewStyle(CircularProgressViewStyle(tint: .backgroundInvert))
                .scaleEffect(1.5)
        }
    }
}

#Preview {
    LoadingView()
}
