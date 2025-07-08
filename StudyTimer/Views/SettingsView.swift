
import Foundation
import SwiftUI
import AVFoundation

/*Want to wrap arrows in buttons*/

struct SettingsView: View {
    
    @EnvironmentObject private var settingsModel: SettingsViewModel
    @Environment(\.dismiss) var dismiss
    //in future will get from database potentially, or local settings
    //add vars that pass data back in forth between models when settings are updated
    
    /*Want to add save button eventually, also edit back buttan choose new design/color for the settings title*/
    
    var body: some View {
        
        VStack {
            
            VStack {
                
                ZStack {
                    
                    Text("Setting")
                        .font(.title)
                        .bold()
                        .foregroundColor(.black)
                    
                    
                    HStack {
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                           
                        }
                        .padding(.leading)
                        Spacer()
                    }
                }
                .frame(width: screenSize.width, height: 45)
                .padding(.top, 47)
                
                
                Divider().background(Color.black)
            }.padding(.bottom, 5)
            
            ScrollView {
                VStack{
                    VStack {
                        
                        Label { //Title and Icon
                            Text("Timer")
                                .font(.system(size: 20))
                                .bold()
                                .font(.title)
                        } icon: {
                            Image(systemName: "clock")
                                .resizable()
                                .frame(width: 45, height: 45)
                        }.padding(6)
                            .foregroundColor(.gray)
                        
                        Text("Time(minutes)")
                            .padding(.leading, 6)
                            .bold()
                        
                    }.frame(width: screenSize.width, height: 95, alignment: .leading)
                        .background(Color.white)
                        .padding(.bottom, 5)
                    
                    HStack {
                        
                        VStack {
                            
                            Text("StudyTime").bold()
                                .foregroundColor(Color.gray)
                                .hoverEffect()
                            
                            
                            HStack { //StudyTimer edit section, Need to work on touch area for setting time without arrows
                                
                                TextField("\(settingsModel.studyMins)", text: $settingsModel.studyMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)
                                
                                VStack {    //Add button controls, possible change of styling
                                    
                                    Button(action: {
                                        
                                        settingsModel.incrementButtonAction(mode: 0)
                                        
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .foregroundColor(Color.black)
                                            .scaleEffect(settingsModel.studyInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.studyInc)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        
                                        settingsModel.decrementButtonAction(mode: 0)
                                        
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(settingsModel.studyDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.studyDec)
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                
                            }.frame(width: (screenSize.width / 3.5) - 10, height: 50, alignment: .leading)
                                .background(Color(UIColor(hex: 0xefefef)))
                                .cornerRadius(8.0)
                                .padding(.leading, 5)
                            
                            
                            
                            
                        }.frame(width: screenSize.width / 3.5, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                        //.background(Color.red)
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("Short Break").bold()
                                .foregroundColor(Color.gray)
                                .hoverEffect()
                            
                            
                            HStack { //StudyTimer edit section, Need to work on touch area for setting time without arrows
                                
                                TextField("\(settingsModel.shortBreakMins)", text: $settingsModel.shortBreakMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)
                                
                                
                                
                                VStack {
                                    
                                    Button(action: {
                                        settingsModel.incrementButtonAction(mode: 1)
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(settingsModel.shortInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.shortInc)
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    Spacer()
                                    
                                    
                                    
                                    Button(action: {
                                        settingsModel.decrementButtonAction(mode: 1)
                                    }) {
                                        
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(settingsModel.shortDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.shortDec)
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    
                                }
                                
                                
                            }.frame(width: (screenSize.width / 3.5) - 10, height: 50, alignment: .leading)
                                .background(Color(UIColor(hex: 0xefefef)))
                                .cornerRadius(8.0)
                                .padding(.leading, 5)
                            
                            
                        }.frame(width: screenSize.width / 3.5, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                        
                        Spacer()
                        
                        VStack {
                            
                            Text("Long Break").bold()
                                .foregroundColor(Color.gray)
                                .hoverEffect()
                                .padding(.trailing, 10)
        
                            HStack { //StudyTimer edit section, Need to work on touch area for setting time without arrows
                                
                                TextField("\(settingsModel.longBreakMins)", text: $settingsModel.longBreakMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .disabled(true)
                                
                                
                                VStack {
                                    
                                    
                                    Button(action: {
                                        settingsModel.incrementButtonAction(mode: 2)
                                    }) {
                                        
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(settingsModel.longInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.longInc)
                                            .foregroundColor(.black)
                                        
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        settingsModel.decrementButtonAction(mode: 2)
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(settingsModel.longDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.longDec)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                
                                
                            }.frame(width: (screenSize.width / 3.5) - 10, height: 50, alignment: .leading)
                                .background(Color(UIColor(hex: 0xefefef)))
                                .cornerRadius(8.0)
                                .padding(.trailing, 10)
                            
                        }.frame(width: screenSize.width / 3.5, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                        
                    }.frame(width: screenSize.width, height: 95, alignment: .leading)
   
                    VStack {
                        
                        HStack {
                            
                            Text("Auto Start Breaks")
                                .font(.system(size: 16))
                                .bold()
                            
                            
                            Toggle("", isOn: $settingsModel.settings.autoStartBreaks)
                                .onChange(of: settingsModel.settings.autoStartBreaks) { _, _ in
                                }
                        }.padding([.leading, .trailing], 10)
                            .tint(Color.blue)
                        
                        HStack {
                            
                            Text("Auto Start StudyTime")
                                .font(.system(size: 16))
                                .bold()
                            
                            Toggle("", isOn: $settingsModel.settings.autoStartStudy).onChange(of: settingsModel.settings.autoStartStudy) { _, _ in
                            }
                        }.padding([.leading, .trailing], 10)
                            .tint(Color.blue)
                        
                        
                        HStack {
                            
                            Text("Long Break Interval")
                                .font(.system(size: 16))
                                .bold()
                            
                            
                            HStack {
                                
                                TextField("\(settingsModel.longBreakIntv)", text: $settingsModel.longBreakIntv)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 30, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)

                                VStack {
                                    
                                    Button(action: {
                                        settingsModel.incrementLongBreakIntv()
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(settingsModel.longIntvInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.longIntvInc)
                                            .foregroundColor(.black)
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        settingsModel.decrementLongBreakIntv()
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(settingsModel.longIntvDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: settingsModel.longIntvDec)
                                            .foregroundColor(.black)
                                    }
                                    
                                }
                                
                                
                            }.frame(width: (screenSize.width / 3.5) - 10, height: 50, alignment: .leading)
                                .background(Color(UIColor(hex: 0xefefef)))
                                .cornerRadius(8.0)
                                .padding(.leading, 15)
                            
                            Spacer()
                        }
                        .padding(.leading, 10)
                        
                        
                        
                    }.frame(width: screenSize.width, height: 150, alignment: .leading)
                    
                    Divider().background(Color.gray) //theme section
                    
                    
                    HStack {
                        
                        
                        Image(systemName: "wand.and.stars")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.gray)
                            .padding(.leading, 10)
                        
                        Text("Theme")
                            .font(.system(size: 20))
                            .bold()
                            .font(.title)
                            .foregroundColor(Color.gray)
                        
                    }.frame(width: screenSize.width, height: 65, alignment: .leading)
                    
                    
                    HStack {
                        
                        
                        Text("Color Theme")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.leading, 10)
                        
                        Spacer()
                        
                        
                        Button(action: {
                            settingsModel.showColorPickerStudy = true
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.settings.modeColors[0])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 5)
                        .popover(isPresented: $settingsModel.showColorPickerStudy) {
                            ColorPickerView(mode: 0)
                                .onDisappear {
                                    settingsModel.showColorPickerStudy = false
                                }
                        }
                        
                        
                        Button(action: {
                            settingsModel.showColorPickerShort = true
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.settings.modeColors[1])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 5)
                        .popover(isPresented: $settingsModel.showColorPickerShort) {
                            ColorPickerView(mode: 1).onDisappear() {
                                settingsModel.showColorPickerShort = false
                            }
                        }
                        
                        Button(action: { //LongBreak Button
                            settingsModel.showColorPickerLong = true
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.settings.modeColors[2])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 10)
                        .popover(isPresented: $settingsModel.showColorPickerLong) {
                            ColorPickerView(mode: 2).onDisappear() {
                                settingsModel.showColorPickerLong = false
                            }.frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
                        }
                        
                    }.frame(width: screenSize.width, alignment: .leading)
                        .padding(.bottom, 20)
                    
                    HStack {
                        
                        Text("Timer Font")
                            .font(.system(size: 16))
                            .padding(.leading, 11)
                            .bold()
                        
                        
                        Spacer()
                        
                        Menu {
                            Picker(selection: $settingsModel.settings.timerFont, label: EmptyView()) {
                                ForEach(Array(Settings.fonts.keys), id: \.self) { key in
                                    Text(key)
                                        .foregroundColor(.black)
                                        .bold()
                                        .tag(key)
                                }
                            }
                        } label: {
                            
                            HStack {
                                Text("\(settingsModel.settings.timerFont)")
                                    .foregroundColor(.black)
                                    .font(Font.custom(Settings.fonts[settingsModel.settings.timerFont] ?? "Avenir-Medium", size: 16))
                                    .padding(10)
                                
                                
                                Image(systemName: "chevron.up.chevron.down")
                                
                                    .foregroundColor(.black)
                                    .padding(.trailing, 5)
                                
                            }
                            .background(Color(UIColor(hex: 0xefefef)))
                            .cornerRadius(8)
                            .padding(.trailing, 10)
                            
                        }
                        
                    }.frame(width: screenSize.width, height: 60, alignment: .leading)
                    
                    
                    Divider().background(Color.gray)
                        .padding(.top, 10)
                    
                    
                    HStack {
                        
                        Image(systemName: "speaker.wave.1")
                            .resizable()
                            .frame(width: 45, height: 45)
                            .foregroundColor(Color.gray)
                            .padding(.leading, 10)
                        
                        Text("Sound")
                            .font(.system(size: 20))
                            .bold()
                            .font(.title)
                            .foregroundColor(Color.gray)
                        
                        
                    }.frame(width: screenSize.width, height: 60, alignment: .leading)
                    //.background(Color.yellow)
  
                    HStack {
                        
                        
                        Text("Alarm Sound")
                            .padding(.leading, 8)
                            .font(.system(size: 16))
                            .bold()
                        
                        Spacer()
                        
                        Menu {
                            Picker(selection: $settingsModel.settings.alarmSound, label: EmptyView()) {
                                ForEach(Array(Settings.sounds.keys), id: \.self) { key in
                                    Text(key)
                                        .foregroundColor(.black)
                                        .bold()
                                        .tag(key)
                                }
                            }
                        } label: {
                            
                            HStack {
                                Text("\(settingsModel.settings.alarmSound)")
                                    .foregroundColor(.black)
                                    .font(Font.custom("Avenir-Medium", size: 16))
                                    .padding(.leading, 5)
                                    .padding(10)
                                
                                
                                Image(systemName: "chevron.up.chevron.down")
                                
                                    .foregroundColor(.black)
                                    .padding(.trailing, 5)
                                
                            }
                            .background(Color(UIColor(hex: 0xefefef)))
                            .cornerRadius(8)
                            .padding(.trailing, 10)
                        
                        }
                        
                    }.frame(width: screenSize.width, height: 60, alignment: .leading)
                    
                    
                    HStack {
                        
                        Text("Ticking Sound")
                            .font(.system(size: 16))
                            .bold()
                            .padding(.leading, 10)
                        
                        
                        Toggle("", isOn: $settingsModel.settings.tickingOn)
                            .padding(.trailing, 8)
                        
                        
                    }
                    .frame(width: screenSize.width, height: 60, alignment: .leading)
                    .tint(Color.blue)
                    .padding(.bottom)
                    
                }.padding(.bottom, 30)
                
            }
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
            .onAppear {
                settingsModel.studyMins = String(Int(settingsModel.getModeTime(mode: 0)))
                settingsModel.shortBreakMins = String(Int(settingsModel.getModeTime(mode: 1)))
                settingsModel.longBreakMins = String(Int(settingsModel.getModeTime(mode: 2)))
                settingsModel.longBreakIntv = String(settingsModel.longBreakIntv)
            }
    }
}

private struct ColorPickerView: View { //want to convert to centered popup eventually
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var settingsModel: SettingsViewModel
    var mode: Int
    
    
    init (mode: Int) {
        self.mode = mode
        
    }
    
    var body: some View {
        VStack {
            
            Text("Set a color for \(Settings.modes[mode] ?? "Mode")")
                .bold()
                .font(.system(size: 16))
            
            HStack {
                
                ForEach(0..<Settings.allColors.count, id: \.self) { i in
                    Button(action: {
                        settingsModel.selectedColor = Settings.allColors[i]
                        settingsModel.settings.modeColors[mode] = settingsModel.selectedColor
                        
                        if(settingsModel.settings.currentMode == mode) {
                            settingsModel.settings.backgroundColor = settingsModel.settings.modeColors[mode]
                        }
                        dismiss()
                    }) {
                        Rectangle()
                            .fill(Color(UIColor(hex: Settings.allColors[i])))
                            .frame(width: 30, height: 30)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(settingsModel.selectedColor == Settings.allColors[i] ? Color.black : Color.clear, lineWidth: 2))
                    }
                    .disabled(settingsModel.selectedColor == Settings.allColors[i])
                }
            }
            
            
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .center)
            .background(Color.white)
            .onAppear {
                settingsModel.selectedColor = settingsModel.settings.modeColors[mode]
            }
    }
}


#Preview {
    SettingsView()
        .environmentObject(SettingsViewModel())
}
