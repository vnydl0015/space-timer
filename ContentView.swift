//
//  ContentView.swift
//  Space Timer
//
//  Created by Vannyda Long on 12/2/2025.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    @State private var selectedHour = 0
    @State private var selectedMin = 0
    @State private var selectedSec = 0
    
    @State private var rotation: Double = 0
    @State private var myGray = Color(red: 0.44, green: 0.44, blue: 0.46)
    
    @State private var isClicked1 = false
    @State private var isClicked2 = false
    @State private var isClicked3 = false
    @State private var nextPage = false
    
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color.black.ignoresSafeArea()
                
                VStack(spacing: 60) {
                    Text("TIMERS").bold().kerning(2).foregroundColor(Color.white).font(.system(size:20)).padding().transition(.move(edge: .top)).offset(y: isClicked1 || isClicked2 || isClicked3 ? 15 : 0).animation(.easeInOut(duration: 2), value: (isClicked1 || isClicked2 || isClicked3))
                    
                    ZStack {
                        
                        
                        Image("world").resizable().frame(width: 281, height: 281)
                            .rotationEffect(.degrees(rotation))
                            .animation(.linear(duration: 5).repeatForever(autoreverses: false), value:rotation)
                            .onAppear {
                                rotation += 360
                            }
                        
                        Image(isClicked1 ? "WhiteClock1": "GrayClock1")
                            .resizable().frame(width: 180, height: 300)
                            .onTapGesture {
                                isClicked1.toggle()
                                isClicked2 = false
                                isClicked3 = false
                            }
                        
                        Image(isClicked2 ? "WhiteClock2": "GrayClock2")
                            .resizable().frame(width: 343, height: 84)
                            .onTapGesture {
                                isClicked2.toggle()
                                isClicked3 = false
                                isClicked1 = false
                            }
                        
                        Image(isClicked3 ? "WhiteClock3": "GrayClock3")
                            .resizable().frame(width: 300, height: 200)
                            .onTapGesture {
                                isClicked3.toggle()
                                isClicked2 = false
                                isClicked1 = false
                            }
                        
                        if isClicked1 {
                            textLabel(t: "HOURS")
                        } else if isClicked2 {
                            textLabel(t: "MINUTES")
                        } else if isClicked3 {
                            textLabel(t: "SECONDS")
                        } else {
                            Image(systemName: "lock").foregroundColor(.white)
                        }
                        
                    }.transition(.move(edge: .top)).offset(y: isClicked1 || isClicked2 || isClicked3 ? -8 : 0)
                        .animation(.easeInOut(duration: 1), value: (isClicked1 || isClicked2 || isClicked3))
                    
                    if (isClicked1 || isClicked2 || isClicked3) {
                        HStack {
                            Picker("HOURS", selection: $selectedHour) {
                                ForEach(0...23, id: \.self) { hour in
                                    Text(String(format: "%02d", hour)).foregroundColor(.white)
                                }
                            }.kerning(4).bold().background(isClicked1 ? myGray:Color.black)
                                .clipShape(RoundedRectangle(cornerRadius: 25)).overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.black, lineWidth: 3)
                                )
                            
                            
                            
                            Picker("MINUTES", selection: $selectedMin) {
                                ForEach(0...59, id: \.self) { min in
                                    Text(String(format: "%02d", min)).foregroundColor(.white)
                                }
                            }.kerning(4).bold().background(isClicked2 ? myGray:Color.black).clipShape(RoundedRectangle(cornerRadius: 25)).overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 3)
                            )
                            
                            
                            
                            Picker("SECONDS", selection: $selectedSec) {
                                ForEach(0...59, id: \.self) { sec in
                                    Text(String(format: "%02d", sec)).foregroundColor(.white)
                                }
                            }.kerning(4).bold().background(isClicked3 ? myGray:Color.black).clipShape(RoundedRectangle(cornerRadius: 25)).overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(.black, lineWidth: 3)
                            )
                            
                            
                        }
                        .frame(width: 300, height: 50)
                        .pickerStyle(WheelPickerStyle())
                        .transition(.move(edge: .top)).animation(.easeInOut(duration: 1), value: (isClicked1 || isClicked2 || isClicked3))
                    }
                    
                    NavigationLink(destination: TimerView(hours: selectedHour, mins: selectedMin, secs: selectedSec)) {
                        
                        VStack {
                            Text("START").bold().foregroundColor(.white).kerning(4).pickerStyle(WheelPickerStyle())
                                .transition(.move(edge: .bottom)).animation(.easeInOut(duration: 1), value: (isClicked1 || isClicked2 || isClicked3))
                            
                            Button(action: {
                                //
                            }) {
                                Image(systemName: "record.circle").foregroundColor(.white).frame(width: 20, height: 20)
                            }.pickerStyle(WheelPickerStyle())
                                .transition(.move(edge: .bottom)).animation(.easeInOut(duration: 1), value: (isClicked1 || isClicked2 || isClicked3))
                        }
                    }
                    
                    
                    
                    
                    
                    ZStack {
                        Image("tap").resizable().frame(width: 294.5, height: 66)
                        HStack {
                            Image(systemName: "timer")
                            Spacer()
                            Image(systemName: "alarm")
                            Spacer()
                            Image(systemName: "stopwatch")
                        }.foregroundColor(.white).frame(width: 220, height: 66)
                    }.transition(.move(edge: .bottom)).offset(y: isClicked1 || isClicked2 || isClicked3 ? -25 : 0).animation(.easeInOut(duration: 1), value: (isClicked1 || isClicked2 || isClicked3))
                    
                }
            }
        }

    }
    
    func textLabel(t: String) -> some View {
        return Text(t).foregroundColor(Color.white).font(.system(size: 15)).bold()
    }

}

#Preview {
    ContentView()
}
