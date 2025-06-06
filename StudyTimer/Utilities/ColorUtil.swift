//
//  ColorUtil.swift
//  StudyTimer
//
//  Created by Jaden Creech on 2/3/25.
//

import Foundation
import SwiftUI

extension UIColor {
    
    convenience init(hex: Int) {   //hex -> UIColor
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }
    
}


   


