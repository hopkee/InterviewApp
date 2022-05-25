//
//  CustomColors.swift
//  InterviewApp
//
//  Created by Valya on 24.05.22.
//

import Foundation
import UIKit

enum CustomColor {
case mainBlue
case lightBlue
case red
case random
}

class CustomColors {
    
    static func getColor(_ color: CustomColor) -> UIColor {
        switch color {
        case CustomColor.mainBlue:
            return UIColor(red: 34 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1)
        case CustomColor.lightBlue:
            return UIColor(red: 34 / 255, green: 99 / 255, blue: 193 / 255, alpha: 0.5)
        case CustomColor.red:
            return UIColor(red: 208 / 255, green: 47 / 255, blue: 36 / 255, alpha: 1)
        case CustomColor.random:
            return UIColor(red: CGFloat(Int.random(in: 0...255) / 255), green: CGFloat(Int.random(in: 0...255) / 255), blue: CGFloat(Int.random(in: 0...255) / 255), alpha: 1)
        }
    }
}
