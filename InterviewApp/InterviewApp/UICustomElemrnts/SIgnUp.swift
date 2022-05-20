//
//  File.swift
//  InterviewApp
//
//  Created by Valya on 10.05.22.
//

import Foundation

import UIKit

extension SignUpVC {
    
    func setUpUI() {
//        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
//        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
//        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
//        let conPasPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
//        nameTFOutlet.leftView = namePaddingView
//        nameTFOutlet.leftViewMode = .always
//        emailTFOutlet.leftView = emailPaddingView
//        emailTFOutlet.leftViewMode = .always
//        passwordTFOutlet.leftView = passPaddingView
//        passwordTFOutlet.leftViewMode = .always
//        confirmPassTFOutlet.leftView = conPasPaddingView
//        confirmPassTFOutlet.leftViewMode = .always
//        nameTFOutlet.clipsToBounds = true
//        emailTFOutlet.clipsToBounds = true
//        passwordTFOutlet.clipsToBounds = true
//        confirmPassTFOutlet.clipsToBounds = true
//        nameTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
//        emailTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
//        passwordTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
//        confirmPassTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
//        nameTFOutlet.layer.borderWidth = CGFloat(1)
//        emailTFOutlet.layer.borderWidth = CGFloat(1)
//        passwordTFOutlet.layer.borderWidth = CGFloat(1)
//        confirmPassTFOutlet.layer.borderWidth = CGFloat(1)
//        nameTFOutlet.layer.cornerRadius = 22
//        emailTFOutlet.layer.cornerRadius = 22
//        passwordTFOutlet.layer.cornerRadius = 22
//        confirmPassTFOutlet.layer.cornerRadius = 22
//        nameTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
//        emailTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
//        passwordTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
//        confirmPassTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
//        nameTFOutlet.attributedPlaceholder = NSAttributedString(
//            string: "Your name",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
//        )
//        emailTFOutlet.attributedPlaceholder = NSAttributedString(
//            string: "Email",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
//        )
//        passwordTFOutlet.attributedPlaceholder = NSAttributedString(
//            string: "Password",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
//        )
//        confirmPassTFOutlet.attributedPlaceholder = NSAttributedString(
//            string: "Confirm password",
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
//        )
//        createBtnOutlet.clipsToBounds = true
//        createBtnOutlet.layer.cornerRadius = 22
        errorMsgOutlet.text = "PLease, fill all the fields"
        errorMsgOutlet.isHidden = true
    }
    
}
