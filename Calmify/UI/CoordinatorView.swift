//
//  InitialHome.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 5/6/24.
//

import SwiftUI

struct CoordinatorView: View {
    @State var goToHomeView: Bool = false
    @State var animate: Bool = false
    var body: some View {
        Group {
            if goToHomeView {
                Home()
            } else {
                onBoarding(goToHomeView: $goToHomeView, animate: $animate)
            }
        }
    }
}

#Preview {
    CoordinatorView()
}
