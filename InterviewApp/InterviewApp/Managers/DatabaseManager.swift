//
//  DatabaseManager.swift
//  InterviewApp
//
//  Created by Валентин Величко on 23.04.22.
//

import Foundation
import Firebase
import FirebaseDatabase

final class DatabaseManager {
    
    func getRef() -> DatabaseReference {
        return Database.database(url: "https://interviewapp-3e4fd-default-rtdb.europe-west1.firebasedatabase.app").reference()
    }
    
    func createNewUser(_ user: User) {
        guard let currentUid = AuthManager.shared.getCurrentUserUid() else { return }
        let ref = getRef().child("users").child(currentUid)
        let userDictionary = user.toDictionnary
        ref.setValue(userDictionary)
    }
    
    func createInterviewee(uid: String, _ interviewee: Interviewee) {
        let intervieweeDictionary = interviewee.toDictionnary
        let ref = getRef().child("users").child(uid).child("Interviewees").child(interviewee.id)
        ref.setValue(intervieweeDictionary)
    }
    
    func createInterview(uid: String, _ interview: Interview) {
        let interviewDictionary = interview.toDictionnary
        let ref = getRef().child("users").child(uid).child("Interviews").child(interview.id)
        ref.setValue(interviewDictionary)
    }
    
    func getAllInterviewees(uid: String, completion: @escaping ([Interviewee]) -> Void) {
        let ref = getRef().child("users").child(uid).child("Interviewees")
        ref.getData(completion: { error, snapshot in
            var interviewees: [Interviewee] = []
            guard error == nil else {
                print(error!.localizedDescription)
                return
              }
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let interviewee = Interviewee(snapshot: snapshot) else { return }
                interviewees.append(interviewee)
            }
            completion(interviewees)
        })
    }
    
    func getAllInterviews(uid: String, completion: @escaping ([Interview]) -> Void) {
        let ref = getRef().child("users").child(uid).child("Interviews")
        ref.getData(completion: { error, snapshot in
            var interviews: [Interview] = []
            guard error == nil else {
                print(error!.localizedDescription)
                return
              }
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let interview = Interview(snapshot: snapshot) else { return }
                interviews.append(interview)
            }
            completion(interviews)
        })
    }
    
    func getUncompletedInterviews(uid: String, completion: @escaping ([Interview]) -> Void) {
        let ref = getRef().child("users").child(uid).child("Interviews")
        ref.getData(completion: { error, snapshot in
            var interviews: [Interview] = []
            guard error == nil else {
                print(error!.localizedDescription)
                return
              }
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let interview = Interview(snapshot: snapshot) else { return }
                    if !interview.isCompleted {
                        interviews.append(interview)
                    }
            }
            completion(interviews)
        })
    }
}
