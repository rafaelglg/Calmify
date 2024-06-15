//
//  InitialHomeView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 6/6/24.
//

import SwiftUI

struct InitialHomeView: View {
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
                .font(.system(size: 50))
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
            .onAppear(perform: {
                animate.toggle()
            })
    }
    
    var nextButton: some View {
        HStack {
            Spacer()
            Button {
                withAnimation {
                    goToHomeView = true
                }
            } label: {
                Text("Let's start")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .opacity(animate ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .delay(0.8), value: animate)
                Image(systemName: "arrow.forward")
                    .padding()
                    .font(.title3)
                    .foregroundStyle(.black)
                    .opacity(animate ? 1 : 0)
                    .animation(
                        .easeInOut(duration: 1.5)
                        .delay(0.8), value: animate)
            }
        }
    }
}

#Preview {
    InitialHome()
}
