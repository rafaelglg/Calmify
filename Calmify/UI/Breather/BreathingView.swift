//
//  BreathingView.swift
//  Calmify
//
//  Created by Rafael Loggiodice on 12/6/24.
//

import SwiftUI

struct BreathingView: View {
    @State private var playIsClicked: Bool = false
    
    @State private var breathIn: Bool = false
    @State private var holdBreath: Bool = false
    @State private var breathOut: Bool = false
    @State private var onCircleTapped: Bool = false
    @State private var breatheInCircleSize: Bool = false
    @State private var breatheOutCircleSize :Bool = false
    @State private var timer: Timer?
    @State private var rotationProgress: Double = 0
    @State private var durations = [2,3,4,5]
    @State private var selectedDuration: Int? = nil
    @State private var menuTitleButton: LocalizedStringResource = "Customize your breathing"
    
    let holdColor = Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
    let gradientColors: [Color] = [Color.cyan, Color.indigo]
    
    var body: some View {
        VStack {
            header
            MusicView()
            Breathercircle
            customizeBreathingButton
        }
        .frame(width: 400, height: 350)
        .onDisappear {
            resetAnimation()
        }
    }
}

extension BreathingView {
    
    var header: some View {
        VStack {
            Text("Take a **moment** for yourself")
                .font(.title)
            Text("Play now and start relaxing")
                .font(.title3)
                .foregroundStyle(Color(uiColor: .gray))
            
        }
    }
    
    // MARK: - Customize Breathing Button
    var customizeBreathingButton: some View {
        VStack {
            Menu {
                ForEach(durations, id: \.self) { numberOfSeconds in
                    Button {
                        selectedDuration = numberOfSeconds
                        menuTitleButton = "\(numberOfSeconds) seconds respiration"
                    } label: {
                        HStack {
                            Text("\(numberOfSeconds) seconds respiration")
                            if selectedDuration == numberOfSeconds {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                Text(menuTitleButton)
                    .foregroundStyle(Constants.backgroundInvert)
            }
            .frame(width: 250, height: 65)
            .background(Constants.backgroundColor)
            .clipShape(.rect(cornerRadius: 25))
            .shadow(color: .black.opacity(0.3), radius: 5)
            .onTapGesture {
                resetAnimation()
                onCircleTapped = false
            }
        }
    }
    
    var Breathercircle: some View {
        VStack {
            ZStack {
                ZStack {
                    Circle()
                        .fill(
                            LinearGradient(colors: gradientColors, startPoint: .topLeading, endPoint: .trailing))
                        .frame(width: 250, height: 250)
                        .overlay {
                            Text("Tap me")
                                .font(.title2)
                                .fontWeight(.semibold)
                                .foregroundStyle(.white)
                                .opacity(onCircleTapped ? 0.0 : 0.8)
                        }
                    
                    Circle()
                        .stroke(lineWidth: 5.0)
                        .frame(width: 270, height: 270)
                        .foregroundStyle(holdColor)
                    
                    Circle() //Exhale
                        .trim(from: 0.0, to: 1/4)
                        .stroke(lineWidth: 5.0)
                        .frame(width: 270, height: 270)
                        .foregroundStyle(.cyan)
                        .rotationEffect(.degrees(-90))
                    
                    Circle() //Inhale
                        .trim(from: 0.0, to: 1/4)
                        .stroke(lineWidth: 5.0)
                        .frame(width: 270, height: 270)
                        .foregroundStyle(.green)
                        .rotationEffect(.degrees(90))
                    
                    Capsule() // Right side
                        .trim(from: 1/2, to: 1)
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.gray)
                        .overlay {
                            Capsule()
                                .trim(from: 1/2, to: 1)
                                .stroke()
                                .stroke(lineWidth: 1.0)
                        }
                        .rotationEffect(.degrees(-90))
                        .offset(x: 137)
                    
                    Capsule() // Left side
                        .trim(from: 1/2, to: 1)
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.gray)
                        .overlay {
                            Capsule()
                                .trim(from: 1/2, to: 1)
                                .stroke()
                                .stroke(lineWidth: 1.0)
                        }
                        .rotationEffect(.degrees(90))
                        .offset(x: -137)
                    
                    Capsule() // top
                        .trim(from: 1/2, to: 1)
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.gray)
                        .overlay {
                            Capsule()
                                .trim(from: 1/2, to: 1)
                                .stroke()
                                .stroke(lineWidth: 1.0)
                        }
                        .rotationEffect(.degrees(180))
                        .offset(y: -137)
                    
                    Capsule() // bottom
                        .trim(from: 1/2, to: 1)
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.gray)
                        .overlay {
                            Capsule()
                                .trim(from: 1/2, to: 1)
                                .stroke()
                                .stroke(lineWidth: 1.0)
                        }
                        .offset(y: 137)
                    
                    Capsule() // rotating Capsule
                        .trim(from: 1/2, to: 1)
                        .frame(width: 20, height: 25)
                        .foregroundStyle(.blue)
                        .offset(y: 137)
                        .rotationEffect(.degrees(onCircleTapped ? 360 : 0))
                        .animation(onCircleTapped ? .linear(duration: Double(selectedDuration ?? 3) * 4).repeatForever(autoreverses: false) : .linear(duration: 0), value: onCircleTapped)
                    
                    
                }
                .frame(width: 360, height: 360)
                .onTapGesture {
                    
                    onCircleTapped.toggle()
                    
                    if onCircleTapped {
                        startTimer()
                    } else {
                        resetAnimation()
                    }
                }
                .scaleEffect(breatheInCircleSize ? 1.2 : 1)
                .scaleEffect(breatheOutCircleSize ? 0.835 : 1)
                textInsideCircle
            }
        }
        .padding(10)
    }
    
    var textInsideCircle: some View {
        ZStack {
            if breathIn {
                Text("Breath in")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .bold()
            }
            
            if holdBreath {
                Text("Hold")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .bold()
            }
            if breathOut {
                Text("Breath out")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .bold()
            }
        }
    }
    
    func startTimer() {
        
        let timeSelected = Double(selectedDuration ?? 3)
        let timeInterval = Double(timeSelected / 20)
        
        timer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true) { _ in
            if self.onCircleTapped {
                self.rotationProgress += 0.0125
                if self.rotationProgress >= 1 { // full circle
                    self.rotationProgress = 0
                }
                
                let angle = round(rotationProgress * 360)
                
                switch angle {
                case 5:
                    withAnimation(.linear(duration: timeSelected)) {
                        breatheInCircleSize.toggle()
                    }
                    withAnimation(.linear(duration: 0.2)) {
                        breathIn.toggle()
                    }
                    
                case 90:
                    breathIn.toggle()
                    withAnimation(.linear(duration: 0.3)) {
                        holdBreath.toggle()
                    }
                    
                case 180:
                    holdBreath.toggle()
                    withAnimation(.linear(duration: 0.3)) {
                        breathOut.toggle()
                    }
                    
                    withAnimation(.linear(duration: timeSelected)) {
                        breatheOutCircleSize.toggle()
                    }
                case 270:
                    breathOut.toggle()
                    withAnimation(.linear(duration: 0.3)) {
                        holdBreath.toggle()
                    }
                    
                case 360:
                    holdBreath.toggle()
                    breatheInCircleSize.toggle()
                    breatheOutCircleSize.toggle()
                default:
                    break
                }
            }
        }
    }
    
    func resetAnimation() {
        withAnimation(.linear(duration: 0)) {
            breatheInCircleSize = false
            breatheOutCircleSize = false
        }
        breathIn = false
        holdBreath = false
        breathOut = false
        timer?.invalidate()
        timer = nil
        rotationProgress = 0
    }
}
#Preview {
    BreathingView()
}
