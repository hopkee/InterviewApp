//
//  AuthManager.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import Foundation
import Firebase

final class AuthManager {
    
    static let shared = AuthManager()
    var signedUserUuId: String?
    
    private var userDefaults = UserDefaults()
    private init() {}
    
    func loginUser(uuid: String) {
        userDefaults.set(uuid, forKey: "signedUserUuId")
        signedUserUuId = uuid
    }
    
    func logoutUser() {
        userDefaults.removeObject(forKey: "signedUserUuId")
        signedUserUuId = nil
    }
    
    func isUserSignedIn() -> Bool {
        if let uuid = userDefaults.string(forKey: "signedUserUuId") {
            signedUserUuId = uuid
            return true
        } else {
            return false
        }
    }
    
}
