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
    @State private var showingSettings = false
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var lastTime: Float = 0.0
    
    @State private var startText: String = "Start"
    
    @State private var backgroundTicking: Bool = false
    
    var body: some View {
        
        ZStack {
            
            
            VStack { //Screen
                
                HStack { //Top navigation
                    
                    Label { //Title and Icon
                        Text("StudyTimer")
                            .font(Font.custom("Avenir-Medium", size: 30))
                            .bold()
                        
                    } icon: {
                        Image(systemName: "graduationcap")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }.padding(10)
                        .foregroundColor(.white)
                    //Title and Icon
                    
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
                            showingSettings = true
                            timerVM.pause()
                            lastTime = settingsVM.getModeTime(mode: settingsVM.getMode())
                        }
                        .fullScreenCover(isPresented: $showingSettings) {
                            SettingsView()
                                .environmentObject(settingsVM)
                                .onDisappear() {
                                    showingSettings = false
                                    if(lastTime != settingsVM.getModeTime(mode: settingsVM.getMode())) {
                                        timerVM.reset()
                                        timerVM.minutes = settingsVM.getModeTime(mode: settingsVM.getMode())
                                    }
                              }
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
                            
                            settingsVM.setMode(mode: 0) //0: StudyTime 1: Short 2: long
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
                        
                        
                    }.frame(width: screenSize.width - 70, height: 50, alignment: .leading)
                    //Top Button Controls
                    
                    HStack { //Clock Section
                        
                        VStack {
                            
                            Text("\(timerVM.time)")
                            
                                
                                .font(Font.custom(settingsVM.fonts[settingsVM.timerFont] ?? "Avenir-Medium", size: 55).bold())
                        
                                .alert("Timer Done!", isPresented: $timerVM.showingAlert) {
                                    
        
                                }
                                .padding()
                                .cornerRadius(20)
                                .frame(width: screenSize.width - 80, height: 90)
                                .foregroundColor(.white)
                            
                            
                            
                            
                        }.onReceive(timer) { _ in
                            timerVM.updateCountdown()
                            
                            
                            
                            
                            if(!timerVM.isActive) {
                                startText = "Start"
                            }
                            
                            if(!timerVM.isActive && timerVM.showingAlert) {
                                
                                timerVM.reset()
                                SoundManager.shared.playImportedSound(named: settingsVM.sounds[settingsVM.alarmSound] ?? "defualt_alarm")
                                let lastMode = settingsVM.getMode()
                                settingsVM.nextMode()
                                timerVM.showingAlert = false
                                timerVM.minutes = settingsVM.getModeTime(mode: settingsVM.getMode())
                                
                                
                                if(settingsVM.autoStartStudy) {
                                    if(lastMode == 1 || lastMode == 2) {
                                        timerVM.start(minutes: timerVM.minutes)
                                        startText = "Pause"
                                    }
                                }
                                
                                if(settingsVM.autoStartBreaks) {
                                    if(lastMode == 0) {
                                        timerVM.start(minutes: timerVM.minutes)
                                        startText = "Pause"
                                    }
                                }

                                
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
                            .frame(width: 300, height: 300, alignment: .center)
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
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
    }
}
#Preview {
    BaseView()
       
}
