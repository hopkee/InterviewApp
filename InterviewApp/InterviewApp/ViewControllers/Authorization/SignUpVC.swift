//
//  CreateNewAccountVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import UIKit
import CoreData
import SwiftUI

class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTFOutlet: UITextField!
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var confirmPassTFOutlet: UITextField!
    @IBOutlet weak var createBtnOutlet: UIButton!
    @IBOutlet weak var welcomeMsgLbl: UILabel!
    
    
    @IBAction func nameTFAction(_ sender: UITextField) {
        guard let enteredName = sender.text else { return }
        self.username = enteredName
        if !(enteredName == "") {
            addNameInLabel(enteredName)
        }
    }
    
    @IBAction func emailTFAction(_ sender: UITextField) {
        guard let enteredEmail = sender.text else { return }
        self.email = enteredEmail
    }
    
    @IBAction func exitBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private var username: String?
    private var email: String?
    private var password: String?
    
    var goToMainScreen: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
//        guard let prevNavController = navigationController?.presentingViewController as? UINavigationController else { return }
//        guard let vc = prevNavController.topViewController as? WelcomeVC else { return }
    }
    
    private func addNameInLabel(_ name: String) {
        if let textInLabel = welcomeMsgLbl.text {
            if textInLabel.contains(",") {
                //Deleting username in label
                welcomeMsgLbl.text = welcomeMsgLbl.text!.components(separatedBy: ",").first!
            }
            welcomeMsgLbl.text = welcomeMsgLbl.text! + ", " + name
        }
    }
    
    private func setUpUI() {
        let namePaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
        let passPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
        let conPasPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: nameTFOutlet.frame.size.height))
        nameTFOutlet.leftView = namePaddingView
        nameTFOutlet.leftViewMode = .always
        emailTFOutlet.leftView = emailPaddingView
        emailTFOutlet.leftViewMode = .always
        passwordTFOutlet.leftView = passPaddingView
        passwordTFOutlet.leftViewMode = .always
        confirmPassTFOutlet.leftView = conPasPaddingView
        confirmPassTFOutlet.leftViewMode = .always
        nameTFOutlet.clipsToBounds = true
        emailTFOutlet.clipsToBounds = true
        passwordTFOutlet.clipsToBounds = true
        confirmPassTFOutlet.clipsToBounds = true
        nameTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        emailTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        passwordTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        confirmPassTFOutlet.layer.borderColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1).cgColor
        nameTFOutlet.layer.borderWidth = CGFloat(1)
        emailTFOutlet.layer.borderWidth = CGFloat(1)
        passwordTFOutlet.layer.borderWidth = CGFloat(1)
        confirmPassTFOutlet.layer.borderWidth = CGFloat(1)
        nameTFOutlet.layer.cornerRadius = 22
        emailTFOutlet.layer.cornerRadius = 22
        passwordTFOutlet.layer.cornerRadius = 22
        confirmPassTFOutlet.layer.cornerRadius = 22
        nameTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        emailTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        passwordTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        confirmPassTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        nameTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        emailTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        passwordTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        confirmPassTFOutlet.attributedPlaceholder = NSAttributedString(
            string: "Confirm password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1), NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 15.0)]
        )
        createBtnOutlet.clipsToBounds = true
        createBtnOutlet.layer.cornerRadius = 22
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let addProfilePictureVC = segue.destination as? AddProfilePictureVC {
            addProfilePictureVC.goToMainScreen = goToMainScreen
        }
    }
    
}
