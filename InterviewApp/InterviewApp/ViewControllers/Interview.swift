//
//  Interview.swift
//  InterviewApp
//
//  Created by Валентин Величко on 22.04.22.
//

import Foundation
import FirebaseDatabase

struct Interview {
    var title: String
    var date: Date
    var startDate: Date
    var endDate: Date?
    var duration: Float?
    var interviewee: Interviewee?
    var questions: [String]?
    var notes: String?
    var recordedAudioURL: String?
    var transcription: String?
}

struct Interviewee: Encodable, Decodable {
    var id: String
    var name: String
    var notes: String?
    var phone: String?
    var email: String?
    
    init(name: String, notes: String?, phone: String?, email: String?) {
        self.name = name
        self.notes = notes
        self.phone = phone
        self.email = email
        self.id = String.random(length: 15)
    }
    
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let id = snapshotValue["id"] as? String,
              let name = snapshotValue["name"] as? String,
              let email = snapshotValue["email"] as? String,
              let notes = snapshotValue["notes"] as? String,
              let phone = snapshotValue["phone"] as? String else { return nil }
        self.name = name
        self.email = email
        self.notes = notes
        self.phone = phone
        self.id = id
    }
}
