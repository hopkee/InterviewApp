//
//  CreateNewAccountVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import UIKit
import CoreData


final class SignUpVC: UIViewController {
    
    @IBOutlet weak var nameTFOutlet: UITextField!
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var confirmPassTFOutlet: UITextField!
    @IBOutlet weak var createBtnOutlet: UIButton!
    @IBOutlet weak var welcomeMsgLbl: UILabel!
    @IBOutlet weak var errorMsgOutlet: UILabel!
    
    
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
    
    @IBAction func passwordTFAction(_ sender: UITextField) {
    }
    
    @IBAction func createBtnAction(_ sender: UIButton) {
        if checkAllFieldsForEmpty() {
            let user = createUserModel()
            performSegue(withIdentifier: "GoToProfilePictureSelectingScreen", sender: user)
        } else {
            errorMsgOutlet.isHidden = false
        }
        
    }
    
    @IBAction func exitBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    private var username: String?
    private var email: String?
    private var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
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
    
    private func checkAllFieldsForEmpty() -> Bool {
        
        if let _ = nameTFOutlet.text,
           let _ = emailTFOutlet.text,
           let _ = passwordTFOutlet.text,
           let _ = confirmPassTFOutlet.text {
            return true
        } else {
            return false
        }
        
    }
    
    private func createUserModel() -> User {
        let name = nameTFOutlet.text!
        let email = emailTFOutlet.text!
        let pass = passwordTFOutlet.text!
        let user = User(name: name, email: email, password: pass)
        return user
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToProfilePictureSelectingScreen" {
            if let addProfilePictureVC = segue.destination as? AddProfilePictureVC,
            let user = sender as? User {
                addProfilePictureVC.user = user
            }
        }
    }
    
}
