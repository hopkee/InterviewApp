//
//  AddProfilePictureVC.swift
//  InterviewApp
//
//  Created by Valya on 4.05.22.
//

import UIKit

class AddProfilePictureVC: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var addPictureBtnOutlet: UIButton!
    @IBOutlet weak var skipBtnOutlet: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var goToMainScreen: (() -> ())?
    
    private func setupUI() {
        let defaultUserPicture = UIImage(imageLiteralResourceName: "defualtUserPicture")
        profilePicture.clipsToBounds = true
        profilePicture.layer.cornerRadius = profilePicture.frame.height / 2
        profilePicture.image = defaultUserPicture
        addPictureBtnOutlet.clipsToBounds = true
        addPictureBtnOutlet.layer.cornerRadius = 22
        skipBtnOutlet.clipsToBounds = true
        skipBtnOutlet.layer.cornerRadius = 22
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let successfullyCreatedAccountVC = segue.destination as? SuccesfullyCreatedAccountVC else { return }
        successfullyCreatedAccountVC.goToMainScreen = goToMainScreen
    }

}
