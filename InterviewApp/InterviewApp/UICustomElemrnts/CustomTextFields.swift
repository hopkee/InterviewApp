//
//  CustomTextFields.swift
//  InterviewApp
//
//  Created by Валентин Величко on 10.05.22.
//

import UIKit

@IBDesignable final class CustomTextFields: UITextField {
    
    @IBInspectable var customTextFieldTitle: String? {
        didSet {
            setDefaultSettings()
            setPlaceholder(customTextFieldTitle ?? "Title")
        }
    }
    
    func setDefaultSettings() {
        let PaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: frame.size.height))
        leftView = PaddingView
        leftViewMode = .always
        clipsToBounds = true
        layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        layer.borderWidth = CGFloat(1)
        layer.cornerRadius = 22
        backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
    }
    
    func setPlaceholder(_ title: String) {
        attributedPlaceholder = NSAttributedString(
            string: title,
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 0.5), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)!])
    }

}
