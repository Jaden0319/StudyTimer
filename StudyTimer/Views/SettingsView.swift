
import Foundation
import SwiftUI
import AVFoundation

/*Want to make view scrollable eventually,
  Add potential save button and / or more theme features*/
  





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
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .scaledToFit()
                                .padding(.top, 15)
                                .scaleEffect(studyInc ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: studyInc)
                                .onTapGesture {
                                    studyMins = incrementFormattedNumericString(numericString: studyMins) ?? studyMins
                                    settingsModel.setModeTime(mode: 0, time: Float(studyMins) ?? 25)
                                    AudioServicesPlaySystemSound(1104)
                                    studyInc = true
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        studyInc = false
                                    }
                                }
                            
                        Spacer()
                            
                                
                            Image(systemName: "arrowtriangle.down.fill")
                                .scaledToFit()
                                .padding(.bottom, 15)
                                .scaleEffect(studyDec ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: studyDec)
                                .onTapGesture {
                                    studyMins = decrementFormattedNumericString(numericString: studyMins) ?? studyMins
                                    settingsModel.setModeTime(mode: 0, time: Float(studyMins) ?? 25)
                                    AudioServicesPlaySystemSound(1104)
                                    studyDec = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        studyDec = false
                                    }
                                }
                                .foregroundColor(Color.black)
                            
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
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .scaledToFit()
                                .padding(.top, 15)
                                .scaleEffect(shortInc ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: shortInc)
                                .onTapGesture {
                                    
                                    shortBreakMins = incrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
                                    settingsModel.setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
                                    AudioServicesPlaySystemSound(1104)
                                    shortInc = true
                                    
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        shortInc = false
                                    }
                                    
                                }
                            
                            Spacer()
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .scaledToFit()
                                .padding(.bottom, 15)
                                .scaleEffect(shortDec ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: shortDec)
                                .onTapGesture {
                                    shortBreakMins = decrementFormattedNumericString(numericString: shortBreakMins) ?? shortBreakMins
                                    settingsModel.setModeTime(mode: 1, time: Float(shortBreakMins) ?? 5)
                                    AudioServicesPlaySystemSound(1104)
                                    shortDec = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        shortDec = false
                                    }
                                    
                                    
                                    
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
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .scaledToFit()
                                .padding(.top, 15)
                                .scaleEffect(longInc ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: longInc)
                                .onTapGesture {
                                    longBreakMins = incrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
                                    settingsModel.setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
                                    AudioServicesPlaySystemSound(1104)
                                    longInc = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        longInc = false
                                    }
                                    
                                }
                            
                            Spacer()
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .scaledToFit()
                                .padding(.bottom, 15)
                                .scaleEffect(longDec ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: longDec)
                                .onTapGesture {
                                    longBreakMins = decrementFormattedNumericString(numericString: longBreakMins) ?? longBreakMins
                                    settingsModel.setModeTime(mode: 2, time: Float(longBreakMins) ?? 10)
                                    AudioServicesPlaySystemSound(1104)
                                    longDec = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        longDec = false
                                    }
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
                            
                            Image(systemName: "arrowtriangle.up.fill")
                                .scaledToFit()
                                .padding(.top, 15)
                                .scaleEffect(longIntvInc ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: longIntvInc)
                                .onTapGesture {
                                
                                    longBreakIntv = incrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
                                    settingsModel.setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
                                    AudioServicesPlaySystemSound(1104)
                                    longIntvInc = true
            
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        longIntvInc = false
                                    }
                                    
                                }
                            
                            Spacer()
                            
                            Image(systemName: "arrowtriangle.down.fill")
                                .scaledToFit()
                                .padding(.bottom, 15)
                                .scaleEffect(longIntvDec ? 1.2 : 1.0)
                                .animation(.easeInOut(duration: 0.2), value: longIntvDec)
                                .onTapGesture {
                                    longBreakIntv = decrementFormattedNumericString(numericString: longBreakIntv) ?? longBreakIntv
                                    settingsModel.setLongBreakIntv(intv: Int(longBreakIntv) ?? 2)
                                    AudioServicesPlaySystemSound(1104)
                                    longIntvDec = true
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        longIntvDec = false
                                    }
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
                
              
                Button("") { //StudyTime Button
                }
                .frame(width: 30, height: 30)
                .background(Color(UIColor(hex: settingsModel.mode_colors[0])))
                .cornerRadius(8)
                .padding(.trailing, 5)
                .onTapGesture {
                    showColorPickerStudy = true
                }
                .popover(isPresented: $showColorPickerStudy) {
                    ColorPickerView(mode: 0).onDisappear() {
                        showColorPickerStudy = false
                    }
                    
                    
                }
                
                Button("") { //ShortBreak Button
                    
                    //action
                    
                }

                .frame(width: 30, height: 30)
                .background(Color(UIColor(hex: settingsModel.mode_colors[1])))
                .cornerRadius(8)
                .padding(.trailing, 5)
                .onTapGesture {
                    showColorPickerShort = true
                }
                .popover(isPresented: $showColorPickerShort) {
                    ColorPickerView(mode: 1).onDisappear() {
                        showColorPickerShort = false
                    }
                }
                Button("") { //LongBreak Button
                    
                    //action
                    
                }
                .frame(width: 30, height: 30)
                .background(Color(UIColor(hex: settingsModel.mode_colors[2])))
                .cornerRadius(8)
                .padding(.trailing, 10)
                .onTapGesture {
                    showColorPickerLong = true
                }
                .popover(isPresented: $showColorPickerLong) {
                    ColorPickerView(mode: 2).onDisappear() {
                        showColorPickerLong = false
                    }.frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
                }
                    
                
                
                
            }.frame(width: screenSize.width, alignment: .leading)
                
      
            
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
                        Button("") {
                        }
                        .frame(width: 30, height: 30)
                        .background(Color(UIColor(hex: colors[i])))
                        .cornerRadius(8)
                        .overlay(RoundedRectangle(cornerRadius: 8).stroke(selectedColor == colors[i] ? Color.black : Color.clear, lineWidth: 1.2))
                        .onTapGesture {
                            selectedColor = colors[i]
                            settingsModel.mode_colors[mode] = selectedColor
                            
                            
                            
                            
                            
                           
                            print(selectedColor)
                            dismiss()
                        }.disabled(selectedColor == colors[i])
                            
                        
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
}
