//
//  SignInVC.swift
//  InterviewApp
//
//  Created by Valya on 3.05.22.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var welcomeMessageLbl: UILabel!
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var signInBtnOutlet: UIButton!
    
    @IBAction func exitBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func signInBtnAction(_ sender: UIButton) {
        if let email = emailTFOutlet.text,
           let password = passwordTFOutlet.text {
            dismiss(animated: true)
            AuthManager.shared.loginWith(email: email, password: password)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTFOutlet.frame.size.height))
        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailTFOutlet.frame.size.height))
        emailTFOutlet.leftView = emailPaddingView
        emailTFOutlet.leftViewMode = .always
        passwordTFOutlet.leftView = passPaddingView
        passwordTFOutlet.leftViewMode = .always
        emailTFOutlet.clipsToBounds = true
        passwordTFOutlet.clipsToBounds = true
        emailTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        passwordTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        emailTFOutlet.layer.borderWidth = CGFloat(1)
        passwordTFOutlet.layer.borderWidth = CGFloat(1)
        emailTFOutlet.layer.cornerRadius = 22
        passwordTFOutlet.layer.cornerRadius = 22
        emailTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
        passwordTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 0.5)
        emailTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        passwordTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        signInBtnOutlet.clipsToBounds = true
        signInBtnOutlet.layer.cornerRadius = 22
    }

}
