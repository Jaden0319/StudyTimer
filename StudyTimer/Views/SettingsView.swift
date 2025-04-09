
import Foundation
import SwiftUI


/* Need to add Back button 
   Need initalizer to pass values from settingsModel
   Want to make view scrollable eventually*/


struct SettingsView: View {

    @State private var studyMins: String = "25:00"
    @State private var shortBreakMins: String = "5:00"
    @State private var longBreakMins: String = "10:00"
    
    //add vars that pass data back in forth between models when settings are updated
    var body: some View {
        
        VStack {
            
            VStack { //title
                
                HStack {
                    
                    Text("Settings")
                        .font(.title)
                        .bold()
                        .foregroundColor(.indigo)
                    
                    
                }.frame(width: screenSize.width, height: 45, alignment: .center)
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
                
            }.frame(width: screenSize.width, height: 95, alignment: .leading)
                .background(Color.white)
                .padding(.bottom, 5)
            
            HStack {
                
                VStack {
                    
                    Text("StudyTime").bold()
                        .foregroundColor(Color.gray)
                        .hoverEffect()
                        
                    
                    
                    HStack { //StudyTimer edit section, Need to work on touch area for setting time without arrows
       
                        TextField("\(studyMins):", text: $studyMins)
                            //.background(Color.green)
                            .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                            .padding(.leading, 10)
                            .scaledToFit()
                            
                            
                        
                        Divider()
                        
                        
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
       
                        TextField("\(shortBreakMins):", text: $shortBreakMins)
                            //.background(Color.green)
                            .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                            .padding(.leading, 10)
                            .scaledToFit()
                            
                            
                        
                        Divider()
                        
                        
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
       
                        TextField("\(longBreakMins):", text: $longBreakMins)
                            //.background(Color.green)
                            .frame(width: ((screenSize.width / 3.5) - 54), height: 50, alignment: .center)
                            .padding(.leading, 10)
                            
                            
                        
                        Divider()
                        
                        
                    }.frame(width: (screenSize.width / 3.5) - 10, height: 50, alignment: .leading)
                    .background(Color(UIColor(hex: 0xefefef)))
                    .cornerRadius(8.0)
                    .padding(.trailing, 10)
                   
                    
                    
   
                    
                }.frame(width: screenSize.width / 3.5, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .top)
                   
                
                
                
            }.frame(width: screenSize.width, height: 95, alignment: .leading)
                
                
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .topLeading)
            .background(Color.white)
    }
}

#Preview {
    SettingsView()
}
