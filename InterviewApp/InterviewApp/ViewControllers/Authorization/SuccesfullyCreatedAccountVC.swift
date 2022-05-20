//
//  SuccesfullyCreatedAccountVC.swift
//  InterviewApp
//
//  Created by Valya on 4.05.22.
//

import UIKit
import FirebaseCore

final class SuccesfullyCreatedAccountVC: UIViewController {
    
    @IBOutlet weak var pictureSuccess: UIImageView!
    @IBOutlet weak var getIntoAppBtnOutlet: UIButton!
    
    @IBAction func getIntoAppBtn(_ sender: Any) {
//        AuthManager.shared.createUser(user: user)
       dismiss(animated: true)
//        AuthManager.shared.loginUser(user: user)
    }
    
    var user: User?
    private let dbManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        AuthManager.shared.createUser(user: user, completion: {
            let uid = AuthManager.shared.getCurrentUserUid()
            self.user?.uid = uid
            self.dbManager.createNewUser(self.user!)
        })
    }
    
    private func setupUI() {
        pictureSuccess.image = UIImage(imageLiteralResourceName: "successIcon")
        getIntoAppBtnOutlet.clipsToBounds = true
        getIntoAppBtnOutlet.layer.cornerRadius = 22
    }

}
