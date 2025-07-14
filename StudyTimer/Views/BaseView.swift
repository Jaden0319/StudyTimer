//
//  BaseView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//  View of main screen 

import SwiftUI

var screenSize:CGSize = UIScreen.main.bounds.size

struct BaseView: View {
    
    @StateObject private var baseVM = BaseViewModel()
    
    var body: some View {
        
        ZStack {
            VStack { //Screen
                
                HStack { //Top navigation
                    
                    Label { //Title and Icon
                        Text("StudyTimer")
                            .font(Font.custom("Avenir-Medium", size: 23))
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
                            baseVM.openStatsAndPauseTimer()
                            
                        } //ReportButton
                        .fullScreenCover(isPresented: $baseVM.showingStats) {
                            StatsView()
                                .environmentObject(baseVM)
                                
                        }.onDisappear(){
                            baseVM.exitStats()
                        }
                    
                    Image(systemName: "gearshape.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.white)
                        .padding(10)
                        .onTapGesture {
                            baseVM.openSettingsAndPauseTimer()
                        }
                        .fullScreenCover(isPresented: $baseVM.showingSettings) {
                            SettingsView()
                                .environmentObject(baseVM.settingsModel)
                                .onDisappear() { //done
                                    baseVM.exitSettings() {
                                        //completion
                                    }
                              }
                        }
                    
                    Group {
                        if baseVM.user.id == nil {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(.trailing, 10)
                        } else {
                            Image(baseVM.user.profileIcon)
                                .resizable()
                                .frame(width: 30, height: 30)
                                .padding(.trailing, 10)
                        }
                    }
                    .onTapGesture {
                        baseVM.openProfileAndPauseTimer()
                    }
                    .fullScreenCover(isPresented: $baseVM.showingProfile) {
                        if baseVM.user.id == nil {
                            LoginView()
                                .environmentObject(baseVM)
                                .onDisappear {
                                    baseVM.exitProfile()
                                    print("Signed in")
                                }
                        } else {
                            ProfileView()
                                .environmentObject(baseVM)
                                .onDisappear {
                                    baseVM.exitProfile()
                                    print("\(baseVM.user.email)'s signed in")
                                }
                        }
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
                
                ZStack {
                   
                    
                    VStack { //Timer Section
                        
                        HStack { //Top Button Controls
                            
                            Button("StudyTime") {
                                //done
                                baseVM.modeClick(mode: 0)
                                //Add Button Action
                            }.font(Font.custom("Avenir-Medium", size: screenSize.width * 0.04))
                                .bold()
                                .font(.largeTitle)
                                .foregroundColor(.white)
                                .shadow(color: .black, radius: 1)
                                //.foregroundColor(baseVM.settingsModel.isStudyTime() ? .black : .white)
                                .padding(5)
                                
                                .background(
                                    baseVM.settingsModel.isStudyTime() ?
                                        Color.black.opacity(0.4) : Color.clear
                                )
                                .cornerRadius(6)
                                .disabled(baseVM.settingsModel.isStudyTime())
                     
                            
                            Spacer()
                            
                            Button("Short Break") {
                                //done\
                                baseVM.modeClick(mode: 1)
                            }.font(Font.custom("Avenir-Medium", size: screenSize.width * 0.04))
                                .bold()
                                .foregroundColor(.white)
                                .padding(5)
                                .background(
                                    baseVM.settingsModel.isShortBreak() ?
                                        Color.black.opacity(0.4) : Color.clear
                                )
                                .cornerRadius(6)
                                .disabled(baseVM.settingsModel.isShortBreak())
                                .shadow(color: .black, radius: 1)
                            
                            Spacer()
                            
                            Button("Long Break") {
                              
                                baseVM.modeClick(mode: 2)
                            }.font(Font.custom("Avenir-Medium", size: screenSize.width * 0.04))
                                .bold()
                                .foregroundColor(.white)
                                .padding(5)
                                .background(
                                    baseVM.settingsModel.isLongBreak() ?
                                        Color.black.opacity(0.4) : Color.clear
                                )
                                .cornerRadius(6)
                                .disabled(baseVM.settingsModel.isLongBreak())
                                .shadow(color: .black, radius: 1)
                            
                        }.frame(width: screenSize.width - 70, height: 50, alignment: .leading)
                        //Top Button Controls
                        
                        HStack { //Clock Section
                            
                            VStack {
                                
                                Text("\(baseVM.time)")
                                    .font(Font.custom(Settings.fonts[baseVM.settingsModel.settings.timerFont] ?? "Avenir-Medium", size: 55).bold())
                                    .alert("Timer Done!", isPresented: $baseVM.timerShowingAlert) {
                                        
                                    }
                                    .padding()
                                    .cornerRadius(20)
                                    .frame(width: screenSize.width - 80, height: 90)
                                    .foregroundColor(.white)
                                
                            }.onReceive(baseVM.timer) { _ in
                                baseVM.handleTimerUpdate()
                            }
                            
                        }.frame(width: screenSize.width - 80, height: 110, alignment: .center)
                            .padding(5)
                        //Clock Section
                        
                        //Start Button
                        
                    }.frame(width: screenSize.width - 40, height: (screenSize.height / 3), alignment: .top)
                        .background(Color(UIColor(hex: baseVM.settingsModel.settings.backgroundColor)))
                        .cornerRadius(18)
                        .padding(20) //Timer Section
                        .brightness(0.14)
                    
                    Button("\(baseVM.startText)") { //done
                        baseVM.startButtonClick()
                    }.buttonStyle(startButtonStyle(color: baseVM.settingsModel.settings.backgroundColor, pressed: baseVM.timerIsActive))
                        .padding(.top, 150)
                }
            }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
                .background(Color(UIColor(hex: baseVM.settingsModel.settings.backgroundColor)))
                .ignoresSafeArea() //Screen
            
            
            
            
            Spacer()
              
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
    }
    
}

#Preview {
    BaseView()
}
