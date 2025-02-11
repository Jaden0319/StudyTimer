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
                        
                        settingsVM.setMode(mode: 0) //0: StudyTime 1: Short 2: Long
                        timerVM.reset()
                        timerVM.minutes = settingsVM.getModeTime(mode: 0)
            
                        //Add Button Action
                    }.font(.system(size: 16))
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(settingsVM.isStudyTime() ? .black : .white)
                    .padding(2)
                    .disabled(settingsVM.isStudyTime())
                   
                    
                    Spacer()
                   
                    Button("Short Break") {
                        
                        settingsVM.setMode(mode: 1)
                        //Save time before reset for leaderboard in future if in StudyTime
                        timerVM.reset()
                        timerVM.minutes = settingsVM.getModeTime(mode: 1)
                        
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(settingsVM.isShortBreak() ? .black : .white)
                        .padding(2)
                        .disabled(settingsVM.isShortBreak())
               
                   Spacer()
                        
                    Button("Long Break") {
                        
                        settingsVM.setMode(mode: 2)
                        //Save time before reset for leaderboard in future if in StudyTime
                        timerVM.reset()
                        timerVM.minutes = settingsVM.getModeTime(mode: 2)
                        
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(settingsVM.isLongBreak() ? .black : .white)
                        .padding(2)
                        .disabled(settingsVM.isLongBreak())
                        
                        
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
                            timerVM.reset()
                            AudioServicesPlaySystemSound(1026)
                            settingsVM.nextMode()
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
                        }
                        else {
                            timerVM.pause()
                            startText = "Start"
                        }
                        
                        AudioServicesPlaySystemSound(1104)

                    }.buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 1))
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(hex: settingsVM.backgroundColor)))
                        .bold()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .shadow(radius: 5)
                        
                        
    
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
