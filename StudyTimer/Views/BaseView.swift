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
            
            
            Divider()  //End of top navigation
                .frame(width: screenSize.width - 55, alignment: .top)
                .background(Color.black)
                .opacity(0.6)
                
            VStack { //Timer Section
                
                HStack { //Top Button Controls
                    
                    Button("StudyTime") {
                        //Add Button Action
                    }.font(.system(size: 16))
                    .bold()
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(2)
                   
                      
                    Spacer()
                   
                    Button("Short Break") {
                        //Add Button Action
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(2)
               
                   Spacer()
                        
                    Button("Long Break") {
                        //Add Button Action
                    }.font(.system(size: 16))
                        .bold()
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(2)
                        
                       
                }.frame(width: screenSize.width - 90, height: 50, alignment: .leading) //Top Button Controls
                
         
                HStack { //Clock Section
                    
                }.frame(width: screenSize.width - 110, height: 110, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .background(Color.blue)
                    .padding(5) //Clock Section
                
                
                VStack {  //Start Button
                    
                    Button("START") {
                        
                        
                    }.buttonStyle(.bordered)
                        .buttonBorderShape(.roundedRectangle(radius: 1))
                        .background(Color.white)
                        .foregroundColor(Color(UIColor(hex: 0xE84D4D)))
                        .bold()
                        .frame(width: 300, height: 300, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        
                    
                    
                }.frame(width: screenSize.width - 150, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .padding() //Start Button
            
                
                
                
            }.frame(width: screenSize.width - 50, height: (screenSize.height / 3), alignment: .top)
                .background(Color(UIColor(hex: 0xE07879)))
                .cornerRadius(18)
                .padding(20) //Timer Section
                 
                                
            
            
        }.frame(width: screenSize.width, height: screenSize.height, alignment: .top)
            .background(Color(UIColor(hex: 0xE84D4D)))
            .ignoresSafeArea() //Screen
        
    }
}
  
#Preview {
    BaseView()
        
}
