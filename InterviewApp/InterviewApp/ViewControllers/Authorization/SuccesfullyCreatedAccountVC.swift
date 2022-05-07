//
//  SuccesfullyCreatedAccountVC.swift
//  InterviewApp
//
//  Created by Valya on 4.05.22.
//

import UIKit

class SuccesfullyCreatedAccountVC: UIViewController {
    
    @IBOutlet weak var pictureSuccess: UIImageView!
    @IBOutlet weak var getIntoAppBtnOutlet: UIButton!
    
    @IBAction func getIntoAppBtn(_ sender: Any) {
        dismiss(animated: true)
    }
    
    var goToMainScreen: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let closure = goToMainScreen {
            closure()
        }
    }
    
    private func setupUI() {
        pictureSuccess.image = UIImage(imageLiteralResourceName: "successIcon")
        getIntoAppBtnOutlet.clipsToBounds = true
        getIntoAppBtnOutlet.layer.cornerRadius = 22
    }

}
