//
//  InitialHome.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 5/6/24.
//

import SwiftUI

struct InitialHome: View {
    @State var goToHomeView: Bool = false
    @State var animate: Bool = false
    var body: some View {
        if goToHomeView {
            Home()
        } else {
            InitialHomeView(goToHomeView: $goToHomeView, animate: $animate)
        }
    }
}

#Preview {
    InitialHome()
}
