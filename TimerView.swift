//
//  TimerView.swift
//  Space Timer
//
//  Created by Vannyda Long on 12/2/2025.
//


import SwiftUI
import UIKit

struct TimerView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var hours: Int
    var mins: Int
    var secs: Int
    
    @State private var remainingTime: Int
    @State private var isRunning = true
    @State private var myGray = Color(red: 0.44, green: 0.44, blue: 0.46)
    @State private var rotation: Double = 0
    
    var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    init(hours: Int, mins: Int, secs: Int) {
        self.hours = hours
        self.mins = mins
        self.secs = secs
        self._remainingTime = State(initialValue: (hours * 3600) + (mins * 60) + secs)
    }
    
    func formattedTime() -> String {
        let h = remainingTime / 3600
        let m = (remainingTime % 3600) / 60
        let s = remainingTime % 60
        return String(format: "%02d:%02d:%02d", h, m, s)
    }
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack(spacing: 60) {
            
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) { Image(systemName: "arrow.left").padding() }
                    Spacer()
                    Text("TIMING").bold().kerning(4)
                    Spacer()
                    Button(action: {
                        //
                    })
                    { Text("Edit").padding().font(.system(size: 15)) }
                }
                .padding(.horizontal)
                .foregroundColor(.white)
                
                ZStack {
                    Image("warp").resizable().frame(width: 400, height: 400)
                    Image("world")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .offset(x:-20, y: 30)
                        .rotationEffect(.degrees(rotation))
                        .animation(.linear(duration: 1), value: rotation) // Smooth transition
                }
                .offset(y: 80)
                .frame(width: 250, height: 250)
                .onReceive(timer) { _ in
                    if isRunning && remainingTime > 0 {
                        remainingTime -= 1
                        rotation += 260
                    }
                }
                
                Text("\(formattedTime())")
                    .bold()
                    .foregroundColor(.white)
                    .offset(y: 140)
                    .font(.system(size: 25))
                
                Spacer()
                
                Button(action: {
                    isRunning.toggle()
                }) {
                    Text(isRunning ? "PAUSE" : "CONTINUE")
                        .foregroundColor(.white)
                        .bold()
                        .kerning(4)
                }.offset(y:30)
                
                Image(systemName: isRunning ? "pause.circle" : "play")
                    .foregroundColor(.white)
                    .offset(y: -10)
                    .frame(width: 20, height: 20)
                
                Button(action: {
                    remainingTime = 0
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Reset")
                        .foregroundColor(myGray)
                        .font(.system(size: 15))
                }
                .offset(y: -20)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
