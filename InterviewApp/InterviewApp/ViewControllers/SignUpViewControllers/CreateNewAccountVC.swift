//
//  CreateNewAccountVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import UIKit

class CreateNewAccountVC: UIViewController {
    
    @IBOutlet weak var nameTFOutlet: UITextField!
    @IBOutlet weak var emailTFOutlet: UITextField!
    @IBOutlet weak var passwordTFOutlet: UITextField!
    @IBOutlet weak var confirmPassTFOutlet: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        nameTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        emailTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        passwordTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
        confirmPassTFOutlet.backgroundColor = UIColor(red: 218 / 255, green: 235 / 255, blue: 254 / 255, alpha: 1)
    }

}
