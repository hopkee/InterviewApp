//
//  CustomButtons.swift
//  InterviewApp
//
//  Created by Валентин Величко on 11.05.22.
//

import UIKit
import SwiftUI

@IBDesignable final class CustomButtons: UIButton {
    
    @IBInspectable var button: String? {
        didSet {
            defaultConfiguration()
            switch button {
            case "primaryButton":
                configurePrimaryButton()
            case "secondaryButton":
                configureSecondaryButton()
            case "verticalAligmentButton":
                configureVerticalAligmentButton()
            default:
                break
            }
        }
    }
    
    func setCustomTitle(_ title: String) {
        configuration?.attributedTitle = AttributedString(NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 12.0)!]))
    }
    
    func configurePrimaryButton() {
        backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
    }
    
    func configureSecondaryButton() {
        backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
    }
    
    func configureVerticalAligmentButton() {
        backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
    }
    
    func defaultConfiguration() {
        clipsToBounds = true
        layer.cornerRadius = 22
    }
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
