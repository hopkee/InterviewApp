//
//  AuthManager.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import Foundation
import FirebaseAuth

final class AuthManager {
    
    static let shared = AuthManager()

    private init() {}
    
    func onboardingWasShown() {
        let defaults = UserDefaults.standard
        defaults.set(true, forKey: "onboardingWasShownToUser")
    }
    
    func wasOnboardingShownToUser() -> Bool {
        let defaults = UserDefaults.standard
        return defaults.bool(forKey: "onboardingWasShownToUser")
    }
    
    func loginUser(user: User?) {
        if let user = user,
           let password = user.password {
            Auth.auth().signIn(withEmail: user.email, password: password)
        }
    }
    
    func loginWith(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logoutUser() {
        try! Auth.auth().signOut()
    }
    
    func createUser(user: User?) {
        if let user = user,
           let password = user.password {
            Auth.auth().createUser(withEmail: user.email, password: password)
        }
    }
    
    func createUser(user: User?, completion: @escaping (() -> ())) {
        if let user = user,
           let password = user.password {
            Auth.auth().createUser(withEmail: user.email, password: password, completion: { _, _ in
                completion()
            })
        }
    }
    
    func getCurrentUserUid() -> String? {
        guard let user = Auth.auth().currentUser else { return nil }
        return user.uid
    }
    
    func getCurrentUser(completion: @escaping ((User) -> Void)) {
        let currentUserUid = getCurrentUserUid()
        let dbManager = DatabaseManager()
        let ref = dbManager.getRef().child("users").child(currentUserUid!)
        ref.getData(completion: { error, snapshot in
            guard error == nil else {
                print(error!.localizedDescription)
                return
              }
            guard let snapshotValue = snapshot.value as? [String: Any] else { return }
            let username = snapshotValue["name"] as? String
            let email = snapshotValue["email"] as? String
            let password = snapshotValue["password"] as? String
            let uid = snapshotValue["uid"] as? String
            let photoUrl = snapshotValue["photoUrl"] as? URL
            let currentUser = User(name: username!, email: email!, password: password!, uid: uid!, photoUrl: photoUrl!)
            completion(currentUser)
        })
    }
    
}
