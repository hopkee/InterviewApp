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
    
    func loginUser(user: User?) {
        if let user = user {
            Auth.auth().signIn(withEmail: user.email, password: user.password)
        }
    }
    
    func loginWith(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logoutUser() {
        try! Auth.auth().signOut()
    }
    
    func createUser(user: User?) {
        if let user = user {
            Auth.auth().createUser(withEmail: user.email, password: user.password)
        }
    }
    
}
