//
//  WelcomeVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import UIKit

class WelcomeVC: UIViewController {
    
    @IBOutlet weak var signUpBtnOutlet: UIButton!
    @IBOutlet weak var signInBtnOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    private func setUpUI() {
        signUpBtnOutlet.clipsToBounds = true
        signUpBtnOutlet.layer.cornerRadius = 22
        signInBtnOutlet.clipsToBounds = true
        signInBtnOutlet.layer.cornerRadius = 22
    }

}
