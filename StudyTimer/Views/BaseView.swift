//
//  BaseView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//  View of main screen 

import SwiftUI
import SwiftData
import AVFoundation
var screenSize:CGSize = UIScreen.main.bounds.size



struct BaseView: View {
    
    @StateObject private var timerVM = TimerModel()
    @StateObject private var settingsVM = SettingsModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var startText: String = "Start"
   
    
    var body: some View {
        
        VStack { //Screen
            
            HStack { //Top navigation
                
                Label { //Title and Icon
                    Text("StudyTimer")
                        .font(.system(size: 24))
                        .bold()
                        .font(.title)
                } icon: {
                    Image(systemName: "graduationcap")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }.padding(10)
                    .foregroundColor(.white)//Title and Icon
                    
                Spacer()
                
                Image(systemName: "chart.bar.fill") //Report Button
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .onTapGesture {
                        //Add tap gesture code
                    } //ReportButton
                
                
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(10)
                    .onTapGesture {
                        //Add Tap Gesture Code
                    }
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
                    .onTapGesture {
                        //Add Tap Gesture Code
                    }
                
                
            }.frame(width: screenSize.width, height: 70, alignment: .topLeading)
                .padding(.top, 60)
                .padding(.leading, 10)
                .padding(.trailing, 10)
                //Edit in size func for scale (60)
                //Top Navigation
            
            Divider() //End of top navigation
                .frame(width: screenSize.width - 55, alignment: .top)
                .background(Color.black)
                .opacity(0.6)
                
            VStack { //Timer Section
                
                HStack { //Top Button Controls
                    
                    Button("StudyTime") {
                        
                        settingsVM.backgroundColor = settingsVM.mode_color["StudyTime"] ?? 0xE84D4D
                        settingsVM.mode = "StudyTime"
                        timerVM.reset()
                        timerVM.minutes = settingsVM.mode_time["StudyTime"] ?? 25.0
                        
                        
                        //Add Button Action
                    }.font(.system(size: 16))
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(settingsVM.mode == "StudyTime" ? .black : .white)
                    .padding(2)
                    .disabled(settingsVM.mode == "StudyTime")
                    
                
                   
                    Spacer()
                   
                    Button("Short Break") {
                        
                        settingsVM.backgroundColor = settingsVM.mode_color["ShortBreak"] ?? 0x2eaace
                        settingsVM.mode = "ShortBreak"
        
                        //Save time before reset for leaderboard in future if in StudyTime
                        timerVM.reset()
                        timerVM.minutes = settingsVM.mode_time["ShortBreak"] ?? 5.0
                        
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(settingsVM.mode == "ShortBreak" ? .black : .white)
                        .padding(2)
                        .disabled(settingsVM.mode == "ShortBreak")
               
                   Spacer()
                        
                    Button("Long Break") {
                        
                        settingsVM.backgroundColor = settingsVM.mode_color["LongBreak"] ?? 0x11669c
                        settingsVM.mode = "LongBreak"
                        //Save time before reset for leaderboard in future if in StudyTime
                        timerVM.reset()
                        timerVM.minutes = settingsVM.mode_time["LongBreak"] ?? 10.0
                        
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(settingsVM.mode == "LongBreak" ? .black : .white)
                        .padding(2)
                        .disabled(settingsVM.mode == "LongBreak")
                        
                        
                       
                }.frame(width: screenSize.width - 90, height: 50, alignment: .leading) //Top Button Controls
                
                HStack { //Clock Section
                    
                    VStack {
                        
                        Text("\(timerVM.time)")
                            .font(.system(size: 55, weight: .medium, design: .rounded))
                            .alert("Timer Done!", isPresented: $timerVM.showingAlert) {
                                
                               
                                

                            }
                            .padding()
                            .cornerRadius(20)
                            .frame(width: screenSize.width - 190, height: 90)
                            .foregroundColor(.white)
                            
                            
                    }.onReceive(timer) { _ in
                        timerVM.updateCountdown()
                        
                        if(!timerVM.isActive) {
                            startText = "Start"
                        }
                        
                        if(!timerVM.isActive && timerVM.showingAlert) {
                            
                            //Save time before reset for leaderboard in future if in StudyTime
                            //Add Code for alternating between breaks
                            
                            timerVM.reset()
                            
                            
                            AudioServicesPlaySystemSound(1026)
                            
                            if(settingsVM.mode == "StudyTime") {
                                
                                if(settingsVM.breakCount == settingsVM.longBreakIntv) {
                                    settingsVM.mode = "LongBreak"
                                    settingsVM.breakCount = 0
                                }
                                else if (settingsVM.breakCount < settingsVM.longBreakIntv) {
                                    settingsVM.mode = "ShortBreak"
                                    settingsVM.breakCount += 1
                                }
                            }
                            else if(settingsVM.mode == "ShortBreak") {
                                settingsVM.mode = "StudyTime"
                            }
                            else if(settingsVM.mode == "LongBreak") {
                                settingsVM.mode = "StudyTime"
                            }
                            
                            
                            
                            timerVM.showingAlert = false
                            
                            
                        }
                        
                        
                    }
                    
                }.frame(width: screenSize.width - 80, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding(5)
                    //Clock Section
                
                VStack {  //Start Button
                    
                    Button("\(startText)") {
                        
                        if(!timerVM.isActive) {
                            timerVM.start(minutes: timerVM.minutes)
                            startText = "Pause"
                            AudioServicesPlaySystemSound(1104)
                        }
                        else {
                            timerVM.pause()
                            startText = "Start"
                            AudioServicesPlaySystemSound(1104)
                        }

                    }.buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 1))
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(hex: settingsVM.backgroundColor)))
                        .bold()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
    
                }.frame(width: screenSize.width - 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding() //Start Button
                    

            }.frame(width: screenSize.width - 50, height: (screenSize.height / 3), alignment: .top)
                .background(Color(UIColor(hex: settingsVM.backgroundColor)))
                .cornerRadius(18)
                .padding(20) //Timer Section
                .brightness(0.14)
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
            .background(Color(UIColor(hex: settingsVM.backgroundColor)))
            .ignoresSafeArea() //Screen
        
    }
}

  
#Preview {
    BaseView()
        
}
