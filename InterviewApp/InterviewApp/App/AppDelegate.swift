//
//  AppDelegate.swift
//  InterviewApp
//
//  Created by Valya on 18.04.22.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UITabBarControllerDelegate {

//    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UITabBar.appearance().backgroundColor = CustomColors.getColor(CustomColor.mainBlue)
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().barTintColor = .white
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is NewInterviewView {
                let newVC = NewInterviewView()
                newVC.modalPresentationStyle = .overCurrentContext
            let interviewProcessStoryboard = UIStoryboard(name: "InterviewProcess", bundle: nil)
            guard let interviewInProgressVC = interviewProcessStoryboard.instantiateViewController(withIdentifier: "InterviewInProgress") as? InterviewInProgressVC else { return false }
            interviewInProgressVC.modalPresentationStyle = .fullScreen
                newVC.completion = { interview in
                    interviewInProgressVC.interview = interview
                    tabBarController.present(interviewInProgressVC, animated: true)
                    print("InterviewInProgressVC is presented")
                }
                tabBarController.present(newVC, animated: false)
            return false
            
        }
        return true
    }

}

