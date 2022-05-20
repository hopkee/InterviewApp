//
//  Users.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import Foundation
import UIKit
import FirebaseAuth

struct User: Encodable {
    var name: String
    var email: String
    var password: String?
    var uid: String?
    var photoUrl: URL?
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    init(name: String, email: String, password: String, uid: String) {
        self.name = name
        self.email = email
        self.password = password
        self.uid = uid
    }
    
    init(name: String, email: String, password: String, uid: String, photoUrl: URL) {
        self.name = name
        self.email = email
        self.password = password
        self.uid = uid
        self.photoUrl = photoUrl
    }
}

