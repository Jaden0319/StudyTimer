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
    var body: some View {
        
        VStack {
            
            HStack { //Top navigation
                
                Label { //Title and Icon
                    Text("StudyTimer")
                        .font(.system(size: 24))
                        .bold()
                        .font(.title)
                        
                } icon: {
                    Image(systemName: "graduationcap")
                        .resizable()
                        .frame(width: 50, height: 50)
                }.padding(10)
                    .foregroundColor(.white)//Title and Icon
                       
                
                Image(systemName: "chart.bar.fill") //ReportButton
                    .resizable()
                    .frame(width: 30, height: 25)
                    .foregroundColor(.white)
                    .padding(.leading, 40)
                    .onTapGesture {
                        //Add tap gesture code
                    } //ReportButton
                
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .onTapGesture {
                        //Add Tap Gesture Code
                    }
                
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.white)
                    .padding(.leading, 10)
                    .onTapGesture {
                        //Add Tap Gesture Code
                    }
                
                
            }.frame(width: screenSize.width, height: 70, alignment: .topLeading)
                .padding(.top, 50)
                .padding(.leading, 5)
                .padding(.trailing, 5)
                //Edit in size func for scale (60)
                //Top Navigation
            
            
            Divider()  //End of top navigation
                .frame(width: screenSize.width - 60, alignment: .top)
                .background(Color.black)
                .opacity(0.6)
                
          

                
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
            .background(Color(UIColor(hex: 0xE84D4D)))
            .ignoresSafeArea()
        
    }
}
  
#Preview {
    BaseView()
        
}
