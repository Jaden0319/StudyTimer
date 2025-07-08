//
//  StartButtonStyle.swift
//  StudyTimer
//
//  Created by Jaden Creech on 7/7/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button("Start", action: {
            print("hi")
        }).buttonStyle(startButtonStyle(color: 0x4903fc, pressed: false))
        
    }
}

struct startButtonStyle: ButtonStyle {
    
    var color: Int
    var pressed: Bool
    
    init(color: Int, pressed: Bool) {
        self.color = color
        self.pressed = pressed
    }
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 20, weight: .bold, design: .rounded))
            .foregroundColor(Color(UIColor(hex: color)))
            .frame(width: 80, height: 1)
            .padding()
        
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .fill(Color(UIColor(hex: 0xebebeb)))
                        .stroke(Color(UIColor(hex: 0xebebeb)), lineWidth: 3)
                        .offset(y:pressed ? 0 : 10)
                    RoundedRectangle(cornerRadius: 4)
                        .fill(.white)
                        .stroke(Color(UIColor(hex: 0xebebeb)), lineWidth: 3)
                }
            ).offset(y:pressed ? 10 : 0)
    }
}

#Preview {
    ContentView()
}
