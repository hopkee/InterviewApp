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
    
    @IBAction func addPhotoBtnAction() {
        addPhotoInUserModel()
    }
    
    @IBAction func createBtnAction() {
        performSegue(withIdentifier: "GoToSuccessScreen", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    var user: User?
    
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
    
    private func addPhotoInUserModel() {
        user?.photo = profilePicture.image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSuccessScreen" {
            guard let successfullyCreatedAccountVC = segue.destination as? SuccesfullyCreatedAccountVC else { return }
            successfullyCreatedAccountVC.user = user
        }
    }

}
