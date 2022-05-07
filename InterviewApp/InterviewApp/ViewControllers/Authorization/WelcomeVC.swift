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
    
    private func goToMainScreen() {
        print("Go to main screen")
//        self.navigationController?.dismiss(animated: false)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let tabBar: UIViewController = storyboard.instantiateViewController(withIdentifier: "MainTabBar")
//        guard let mainNavigationController = storyboard.instantiateViewController(withIdentifier: "MainNavigationController") as? UINavigationController else { return }
//        guard let mainScreen = mainNavigationController.topViewController as? MyInterviewsTVC else { return }
//        let allControllers = mainNavigationController.
//        let myInterviews
//        tabBar.selectedIndex = 5
        
//        let appDelegate = UIApplication.shared.delegate as? AppDelegate
//        appDelegate!.window?.rootViewController = myInterviewsVC
//        appDelegate!.window?.makeKeyAndVisible()
//        tabBar.modalPresentationStyle = .overFullScreen
//        self.present(tabBar, animated: true)
//        self.navigationController?.pushViewController(tabBar, animated: true)
//        let sceneDelegate = UIApplication.shared.delegate as? SceneDelegate
//        sceneDelegate?.window?.rootViewController = tabBar
//        sceneDelegate?.window?.makeKeyAndVisible()
        self.dismiss(animated: true)
        AuthManager.shared.loginUser(uuid: "testUser")
    }
    
    private func setUpUI() {
        signUpBtnOutlet.clipsToBounds = true
        signUpBtnOutlet.layer.cornerRadius = 22
        signInBtnOutlet.clipsToBounds = true
        signInBtnOutlet.layer.cornerRadius = 22
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToSignUp" {
            guard let signUpNavController = segue.destination as? UINavigationController else { return }
            guard let signUpVC = signUpNavController.topViewController as? SignUpVC else { return }
            signUpVC.goToMainScreen = { [weak self] in
                self?.goToMainScreen()
            }
        }
    }

}
