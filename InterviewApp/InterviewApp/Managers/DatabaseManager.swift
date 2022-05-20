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
}
