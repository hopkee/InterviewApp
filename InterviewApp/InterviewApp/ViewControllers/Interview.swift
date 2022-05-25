//
//  Interview.swift
//  InterviewApp
//
//  Created by Валентин Величко on 22.04.22.
//

import Foundation
import FirebaseDatabase

struct Interview: Encodable, Decodable {
    var id: String
    var title: String
    var startDate: String?
    var isCompleted: Bool
    var duration: String?
    var intervieweeName: String?
    var questions: [String]?
    var notes: String?
    var isAudioRecorded: Bool?
    var transcription: String?
    
    init(title: String, startDate: String?, isCompleted: Bool, intervieweeName: String?, questions: [String]?, notes: String?) {
        self.id = String.random(length: 15)
        self.title = title
        self.startDate = startDate
        self.isCompleted = isCompleted
        self.intervieweeName = intervieweeName
        self.questions = questions
        self.notes = notes
    }
    
    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let id = snapshotValue["id"] as? String,
              let title = snapshotValue["title"] as? String,
              let startDate = snapshotValue["startDate"] as? String,
              let isCompleted = snapshotValue["isCompleted"] as? Bool,
              let intervieweeName = snapshotValue["intervieweeName"] as? String,
              let questions = snapshotValue["questions"] as? [String],
              let notes = snapshotValue["notes"] as? String else { return nil }
        self.title = title
        self.id = id
        self.startDate = startDate
        self.isCompleted = isCompleted
        self.intervieweeName = intervieweeName
        self.questions = questions
        self.notes = notes
        if isCompleted {
            self.duration = snapshotValue["duration"] as? String
        }
        if let transcription = snapshotValue["transcription"] as? String {
            self.transcription = transcription
        }
        if let isAudioRecorded = snapshotValue["isAudioRecorded"] as? Bool {
            self.isAudioRecorded = isAudioRecorded
        }
        if let transcription = snapshotValue["transcription"] as? String {
            self.transcription = transcription
        }
    }

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
