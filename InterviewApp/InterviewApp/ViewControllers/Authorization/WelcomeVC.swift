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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showOnboardingIfNeedIt()
    }
    
    private func showOnboardingIfNeedIt() {
        if !(AuthManager.shared.wasOnboardingShownToUser()) {
            let onboarding = OnboardingVC()
            onboarding.modalPresentationStyle = .fullScreen
            self.present(onboarding, animated: false)
            AuthManager.shared.onboardingWasShown()
        } else {
            return
        }
    }
    
}
