//
//  InitialHomeView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct onBoarding: View {
    @Binding var goToHomeView: Bool
    @Binding var animate: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Breathe...")
                .font(.system(size: 45))
                .opacity(animate ? 1 : 0)
                .animation(
                    .easeIn(duration: 1.0).speed(1), value: animate)
            
            Text("Calmify is here")
                .font(.largeTitle)
                .opacity(animate ? 1 : 0)
                .animation(
                    .easeIn(duration: 1.5).delay(0.8), value: animate)
            
                Image("meditation")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .opacity(animate ? 1: 0)
                    .padding(.bottom, 40)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .delay(0.8), value: animate)
            
            nextButton
        }.padding(.all, 45)
            .onAppear {
                animate.toggle()
            }
    }
    
    //MARK: - Next Button
    var nextButton: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    NotificationManager.shared.requestAuthorization()
                    goToHomeView = true
                }
            } label: {
                Text("Let's start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(Constants.backgroundInvert)
                    .opacity(animate ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .delay(0.8), value: animate)
                Image(systemName: "arrow.forward")
                    .padding()
                    .font(.title3)
                    .foregroundStyle(Constants.backgroundInvert)
                    .opacity(animate ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .delay(0.8), value: animate)
            }
        }
    }
}

#Preview {
    CoordinatorView()
}
