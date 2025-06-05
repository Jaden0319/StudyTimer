
import Foundation
import SwiftUI
import AVFoundation

/*Want to wrap arrows in buttons*/

struct SettingsView: View {
    
    @EnvironmentObject private var settingsModel: SettingsModel
    @State private var studyMins: String = "25"
    @State private var shortBreakMins: String = "5"
    @State private var longBreakMins: String = "10"
    @State private var longBreakIntv: String = "2"
    
    @State private var studyInc = false
    @State private var studyDec = false
    
    @State private var shortInc = false
    @State private var shortDec = false
    
    @State private var longInc = false
    @State private var longDec = false
    
    @State private var longIntvInc = false
    @State private var longIntvDec = false
    
    @State private var showColorPickerStudy = false
    @State private var showColorPickerShort = false
    @State private var showColorPickerLong = false
    
    
    @Environment(\.dismiss) var dismiss
    //in future will get from database potentially, or local settings
    
    //add vars that pass data back in forth between models when settings are updated
    var body: some View {

            VStack {
                
                VStack {
                    
                    ZStack {
                        
                        Text("Settings")
                            .font(.title)
                            .bold()
                            .foregroundColor(.indigo)
                        
                        
                        HStack {
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .resizable()
                                .frame(width: 35, height: 30)
                                .foregroundColor(.gray)
                                .padding(.leading, 16)
                                .onTapGesture {
                                    dismiss()
                                }
                            Spacer()
                        }
                    }
                    .frame(width: screenSize.width, height: 45)
                    .padding(.top, 47)
                    
                    
                    Divider().background(Color.black)
                }.padding(.bottom, 5)
                
                ScrollView {
                    
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
                                
                                TextField("\(studyMins)", text: $studyMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)
                                
                                VStack {    //Add button controls, possible change of styling
                                    
                                    Button(action: {
                                        studyMins = incrementFormattedNumericString(numericString: studyMins) ?? studyMins
                                        settingsModel.setModeTime(mode: 0, time: Float(studyMins) ?? 25)
                                        AudioServicesPlaySystemSound(1104)
                                        studyInc = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            studyInc = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .foregroundColor(Color.black)
                                            .scaleEffect(studyInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: studyInc)
                                            
                                    }
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        studyMins = decrementFormattedNumericString(numericString: studyMins) ?? studyMins
                                        settingsModel.setModeTime(mode: 0, time: Float(studyMins) ?? 25)
                                        AudioServicesPlaySystemSound(1104)
                                        studyDec = true

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            studyDec = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(studyDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: studyDec)
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
                                
                                TextField("\(shortBreakMins)", text: $shortBreakMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)
                                
                                
                                
                                VStack {
                                    
                                    Button(action: {
                                        shortBreakMins = incrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
                                        settingsModel.setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
                                        AudioServicesPlaySystemSound(1104)
                                        shortInc = true

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            shortInc = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(shortInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: shortInc)
                                            .foregroundColor(Color.black)
                                    }
                                    
                                    Spacer()
                                    
                                    
                                    
                                    Button(action: {
                                        
                                        shortBreakMins = decrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
                                        settingsModel.setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
                                        AudioServicesPlaySystemSound(1104)
                                        shortDec = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            shortDec = false
                                        }
                                    }) {
                                        
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(shortDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: shortDec)
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
                                
                                TextField("\(longBreakMins)", text: $longBreakMins)
                                //.background(Color.green)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                                    .padding(.leading, 10)
                                    .disabled(true)
                                
                                
                                VStack {
                                    
                                    
                                    Button(action: {
                                        longBreakMins = incrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
                                        settingsModel.setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
                                        AudioServicesPlaySystemSound(1104)
                                        longInc = true
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            longInc = false
                                        }
                                        
                                    }) {
                                        
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(longInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: longInc)
                                            .foregroundColor(.black)
      
                                    }
                    
                                    Spacer()
                                    
                                    Button(action: {
                                        longBreakMins = decrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
                                        settingsModel.setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
                                        AudioServicesPlaySystemSound(1104)
                                        longDec = true
                                        
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            longDec = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(longDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: longDec)
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
                            
                            
                            Toggle("", isOn: $settingsModel.autoStartBreaks)
                                .onChange(of: settingsModel.autoStartBreaks) { _, _ in
                                    settingsModel.autoStartBreaksToggle()
                                }
                        }.padding([.leading, .trailing], 10)
                            .tint(Color.blue)
                        
                        HStack {
                            
                            Text("Auto Start StudyTime")
                                .font(.system(size: 16))
                                .bold()
                            
                            Toggle("", isOn: $settingsModel.autoStartStudy).onChange(of: settingsModel.autoStartStudy) { _, _ in
                                settingsModel.autoStartStudyToggle()
                            }
                        }.padding([.leading, .trailing], 10)
                            .tint(Color.blue)
                        
                        
                        HStack {
                            
                            Text("Long Break Interval")
                                .font(.system(size: 16))
                                .bold()
                            
                            
                            HStack {
                                
                                TextField("\(longBreakIntv)", text: $longBreakIntv)
                                    .frame(width: ((screenSize.width / 3.5) - 54), height: 30, alignment: .center)
                                    .padding(.leading, 10)
                                    .scaledToFit()
                                    .disabled(true)
                                
                                
                                
                                VStack {
                                    
                                    Button(action: {
                                        longBreakIntv = incrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
                                        settingsModel.setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
                                        AudioServicesPlaySystemSound(1104)
                                        longIntvInc = true

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            longIntvInc = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.up.fill")
                                            .scaledToFit()
                                            .padding(.top, 15)
                                            .scaleEffect(longIntvInc ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: longIntvInc)
                                            .foregroundColor(.black)
                                    }
                                    
                                    
                                    Spacer()
                                    
                                    Button(action: {
                                        longBreakIntv = decrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
                                        settingsModel.setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
                                        AudioServicesPlaySystemSound(1104)
                                        longIntvDec = true

                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                            longIntvDec = false
                                        }
                                    }) {
                                        Image(systemName: "arrowtriangle.down.fill")
                                            .scaledToFit()
                                            .padding(.bottom, 15)
                                            .scaleEffect(longIntvDec ? 1.2 : 1.0)
                                            .animation(.easeInOut(duration: 0.2), value: longIntvDec)
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
                            showColorPickerStudy = true
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.mode_colors[0])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 5)
                        .popover(isPresented: $showColorPickerStudy) {
                            ColorPickerView(mode: 0)
                                .onDisappear {
                                    showColorPickerStudy = false
                                }
                        }
                        
                        
                        Button(action: {
                            
                            showColorPickerShort = true
                            
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.mode_colors[1])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 5)
                        .popover(isPresented: $showColorPickerShort) {
                            ColorPickerView(mode: 1).onDisappear() {
                                showColorPickerShort = false
                            }
                        }
                        
                        Button(action: { //LongBreak Button
                            showColorPickerLong = true
                        }) {
                            Rectangle()
                                .fill(Color(UIColor(hex: settingsModel.mode_colors[2])))
                                .frame(width: 30, height: 30)
                                .cornerRadius(8)
                        }
                        .padding(.trailing, 10)
                        .popover(isPresented: $showColorPickerLong) {
                            ColorPickerView(mode: 2).onDisappear() {
                                showColorPickerLong = false
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
                            Picker(selection: $settingsModel.timerFont, label: EmptyView()) {
                                ForEach(Array(settingsModel.fonts.keys), id: \.self) { key in
                                    Text(key)
                                        .foregroundColor(.black)
                                        .bold()
                                        .tag(key)
                                }
                            }
                        } label: {
                            
                            HStack {
                                Text("\(settingsModel.timerFont)")
                                    .foregroundColor(.black)
                                    .font(Font.custom(settingsModel.fonts[settingsModel.timerFont] ?? "Avenir-Medium", size: 16))
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
                            Picker(selection: $settingsModel.alarmSound, label: EmptyView()) {
                                ForEach(Array(settingsModel.sounds.keys), id: \.self) { key in
                                    Text(key)
                                        .foregroundColor(.black)
                                        .bold()
                                        .tag(key)
                                }
                            }
                        } label: {
                            
                            HStack {
                                Text("\(settingsModel.alarmSound)")
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
                        
                        
                        Toggle("", isOn: $settingsModel.tickingOn)
                            .padding(.trailing, 8)
                        
                        
                    }
                    .frame(width: screenSize.width, height: 60, alignment: .leading)
    
                        .tint(Color.blue)
                        
                                        
                }
            }.frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
                .background(Color.white)
                .onAppear {
                    studyMins = String(Int(settingsModel.getModeTime(mode: 0)))
                    shortBreakMins = String(Int(settingsModel.getModeTime(mode: 1)))
                    longBreakMins = String(Int(settingsModel.getModeTime(mode: 2)))
                    longBreakIntv = String(settingsModel.longBreakIntv)
                }
        
            
          
        
        
    }
}


func incrementFormattedNumericString(numericString:String, increment by:Int=1) -> String? {
    
    guard let numericValue = Int(numericString) else {
        return nil }
    
    if(numericValue == 90) {
        AudioServicesPlaySystemSound(1104)
        return String(format: "%d", numericValue)
    }
   
    return String(format: "%d", numericValue + by)
}

func decrementFormattedNumericString(numericString:String, decrement by:Int=1) -> String? {
    
    guard let numericValue = Int(numericString) else { return nil }
    
    if(numericValue == 1) {
        AudioServicesPlaySystemSound(1104)
        return String(format: "%d", numericValue)
        
    }
    return String(format: "%d", numericValue - by)
}


struct ColorPickerView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var settingsModel: SettingsModel
    var mode: Int
    @State private var selectedColor: Int = 0
    
    init (mode: Int) {
        self.mode = mode
        
        }
       
    
  
    var body: some View {
        
        VStack {
           
            Text("Set a color for \(settingsModel.modes[mode] ?? "")")
                .bold()
                .font(.system(size: 16))
            
            HStack {
                
                let colors = settingsModel.getColors()
                
                ForEach(0..<colors.count, id: \.self) { i in
                    Button(action: {
                        
                        selectedColor = colors[i]
                        settingsModel.mode_colors[mode] = selectedColor
                        dismiss()
 
                    }) {
                        Rectangle()
                            .fill(Color(UIColor(hex: colors[i])))
                            .frame(width: 30, height: 30)
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedColor == colors[i] ? Color.black : Color.clear, lineWidth: 2))
                        }
                        .disabled(selectedColor == colors[i])
                            
                        
                    }
                
            }
            
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .center)
            .background(Color.white)
            .onAppear {
                    selectedColor = settingsModel.mode_colors[mode]
                }
    }
}


#Preview {
    SettingsView()
        .environmentObject(SettingsModel())
}
