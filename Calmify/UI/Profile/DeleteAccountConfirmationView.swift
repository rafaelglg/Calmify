//
//  DeleteAccountConfirmationView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 19/7/24.
//

import SwiftUI

struct DeleteAccountConfirmationView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Spacer()
                
                middleText
                Button(role: .destructive) {
                    print("")
                } label: {
                    Text("Delete account")
                        .fontWeight(.semibold)
                }
                .controlSize(.extraLarge)
                .buttonBorderShape(.capsule)
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .navigationTitle("Deleting account")
            .frame(maxWidth: .infinity)
            .background(Color.background)
            .ignoresSafeArea()
        }
    }
}

extension DeleteAccountConfirmationView {
    var middleText: some View {
        Text("To use **Calmify** again you need to create a account")
            .font(.title3)
    }
}

#Preview {
    DeleteAccountConfirmationView()
}
