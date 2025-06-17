//
//  BaseView.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//  View of main screen 

import SwiftUI
import SwiftData

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
                            //Add tap gesture code
                        } //ReportButton
                    
                    
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
                                    baseVM.exitSettings()
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
                            //done
                            baseVM.modeClick(mode: 0)
                            //Add Button Action
                        }.font(.system(size: 16))
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(baseVM.settingsModel.isStudyTime() ? .black : .white)
                            .padding(2)
                            .disabled(baseVM.settingsModel.isStudyTime())
                        
                        Spacer()
                        
                        Button("Short Break") {
                            //done
                            baseVM.modeClick(mode: 1)
                        }.font(.system(size: 16))
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(baseVM.settingsModel.isShortBreak() ? .black : .white)
                            .padding(2)
                            .disabled(baseVM.settingsModel.isShortBreak())
                        
                        Spacer()
                        
                        Button("Long Break") {
                            //done
                            baseVM.modeClick(mode: 2)
                        }.font(.system(size: 16))
                            .bold()
                            .font(.largeTitle)
                            .foregroundColor(baseVM.settingsModel.isLongBreak() ? .black : .white)
                            .padding(2)
                            .disabled(baseVM.settingsModel.isLongBreak())
                        
                        
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
                        
                    }.frame(width: screenSize.width - 80, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(5)
                    //Clock Section
                    
                    VStack {  //Start Button
                        
                        Button("\(baseVM.startText)") { //done
                            baseVM.startButtonClick()
                        }.buttonStyle(.bordered)
                            .buttonBorderShape(.roundedRectangle(radius: 1))
                            .background(Color.white)
                            .foregroundColor(Color(UIColor(hex: baseVM.settingsModel.settings.backgroundColor)))
                            .bold()
                            .frame(width: 300, height: 300, alignment: .center)
                            .shadow(radius: 5)
                        
                    }.frame(width: screenSize.width - 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding() //Start Button
                    
                }.frame(width: screenSize.width - 50, height: (screenSize.height / 3), alignment: .top)
                    .background(Color(UIColor(hex: baseVM.settingsModel.settings.backgroundColor)))
                    .cornerRadius(18)
                    .padding(20) //Timer Section
                    .brightness(0.14)
                
            }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
                .background(Color(UIColor(hex: baseVM.settingsModel.settings.backgroundColor)))
                .ignoresSafeArea() //Screen
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
        
    }
}
#Preview {
    BaseView()
}
