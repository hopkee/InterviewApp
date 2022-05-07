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
        UITabBar.appearance().backgroundColor = UIColor(red: 0 / 255, green: 99 / 255, blue: 193 / 255, alpha: 1)
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .systemGray4
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
                if let newVC = tabBarController.storyboard?.instantiateViewController(withIdentifier: "CMViewController") {
                    newVC.modalPresentationStyle = .overCurrentContext
                    tabBarController.present(newVC, animated: false)
                    return false
                }
            }
            return true
    }

}

