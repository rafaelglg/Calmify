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
            Text("Breath...")
                .font(.system(size: 45))
                .opacity(animate ? 1 : 0)
                .animation(
                    .spring(duration: 1.0).speed(1), value: animate)
            
            Text("Calmify is here")
                .font(.system(size: 50))
                .opacity(animate ? 1 : 0)
                .animation(
                    .easeIn(duration: 1.2).delay(0.8), value: animate)
            
            Image("meditation")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(animate ? 1: 0)
                .padding(.bottom, 40)
                .animation(
                    .easeInOut(duration: 1.2).delay(0.8), value: animate)
            
            HStack {
                Spacer()
                Button {
                    goToHomeView = true
                } label: {
                    Image(systemName: "chevron.right")
                        .padding()
                        .foregroundStyle(.white)
                        .frame(width: 80, height: 80)
                        .background(Color(.black))
                        .clipShape(.circle)
                        .opacity(animate ? 1 : 0)
                        .animation(
                            .easeInOut(duration: 1.2)
                            .delay(0.8), value: animate)
                }
                Spacer()
            }
        }.padding(.all, 45)
            .onAppear(perform: {
                animate.toggle()
            })
    }
}

#Preview {
    InitialHome()
}
