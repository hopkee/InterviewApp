//
//  OnboardingVC.swift
//  InterviewApp
//
//  Created by Valya on 25.05.22.
//

import UIKit
import PaperOnboarding

class OnboardingVC: UIViewController {
    
    lazy var buttonSkip: UIButton = {
        let button = UIButton(frame: CGRect(x: view.frame.size.width - 75, y: 50, width: 75, height: 60))
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(CustomColors.getColor(CustomColor.mainBlue), for: .normal)
        button.addTarget(self, action: #selector(skipOnboarding), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
      super.viewDidLoad()

        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.delegate = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        onboarding.addSubview(buttonSkip)
        onboarding.bringSubviewToFront(buttonSkip)
    
        
      // add constraints
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
        let constraint = NSLayoutConstraint(item: onboarding,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: view,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 0)
        view.addConstraint(constraint)
        for attribute: NSLayoutConstraint.Attribute in [.top] {
        let constraint = NSLayoutConstraint(item: buttonSkip,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: onboarding,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: -100)
        view.addConstraint(constraint)
        }
        for attribute: NSLayoutConstraint.Attribute in [.right] {
        let constraint = NSLayoutConstraint(item: buttonSkip,
                                            attribute: attribute,
                                            relatedBy: .equal,
                                            toItem: onboarding,
                                            attribute: attribute,
                                            multiplier: 1,
                                            constant: 100)
        view.addConstraint(constraint)
        }
      }
        buttonSkip.isHidden = true
    }
    
    @objc func skipOnboarding() {
        self.dismiss(animated: true)
    }
}

extension OnboardingVC: PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
            buttonSkip.isHidden = index == 2 ? false : true
    }
    
    func onboardingItemsCount() -> Int {
        3
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        {
           return [
            OnboardingItemInfo(informationImage: UIImage(systemName: "calendar")!,
                                           title: "Plan",
                                     description: "Plan interviews and don't forget anything",
                                        pageIcon: UIImage(systemName: "calendar")!,
                               color: UIColor.white,
                                      titleColor: CustomColors.getColor(CustomColor.mainBlue),
                                descriptionColor: CustomColors.getColor(CustomColor.mainBlue),
                               titleFont: UIFont(name: "Helvetica", size: 30)!,
                               descriptionFont: UIFont(name: "Helvetica", size: 15)!),

             OnboardingItemInfo(informationImage: UIImage(systemName: "person.2")!,
                                            title: "Interview",
                                      description: "Make voice and text record for every interview",
                                         pageIcon: UIImage(systemName: "person.2")!,
                                color: CustomColors.getColor(CustomColor.mainBlue),
                                       titleColor: UIColor.white,
                                 descriptionColor: UIColor.white,
                                        titleFont: UIFont(name: "Helvetica", size: 30)!,
                                descriptionFont: UIFont(name: "Helvetica", size: 15)!),

             OnboardingItemInfo(informationImage: UIImage(systemName: "suit.heart")!,
                                         title: "Enjoy",
                                   description: "Enjoy the way of creating interview",
                                      pageIcon: UIImage(systemName: "suit.heart")!,
                                color: UIColor.white,
                                    titleColor: CustomColors.getColor(CustomColor.mainBlue),
                              descriptionColor: CustomColors.getColor(CustomColor.mainBlue),
                               titleFont: UIFont(name: "Helvetica", size: 30)!,
                               descriptionFont: UIFont(name: "Helvetica", size: 15)!),
           ][index]
        }()
    }
    
}
