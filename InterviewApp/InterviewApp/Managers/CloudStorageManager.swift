//
//  CloudStorageManager.swift
//  InterviewApp
//
//  Created by Valya on 24.05.22.
//

import Foundation
import Firebase

final class CloudStorageManager {
    
    let storageRef = Storage.storage(url: "gs://interviewapp-3e4fd.appspot.com").reference()
    
    func uploadFile(userUID: String, interviewID: String, localFileUrl: URL) {
        
        let fileRef = storageRef.child("\(userUID)/\(interviewID).m4a")
        let localFileURL = localFileUrl
        
        let uploadTask = fileRef.putFile(from: localFileURL, metadata: nil) { _, _ in
            fileRef.downloadURL { (url, error) in
                guard let downloadURL = url else { return }
                print(downloadURL)
            }
          }
        print("File uploaded")
    }
    
    func downloadFileIfNeeded(userUID: String, interviewID: String) {
        if let localDirectoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                                                                FileManager.SearchPathDomainMask.userDomainMask).first {
            let fileName = interviewID + ".m4a"
            let fileURL = localDirectoryURL.appendingPathComponent(fileName)
            
            let fileExists = FileManager().fileExists(atPath: (fileURL.path))
                print("File exist - \(fileExists)")
            if !fileExists {
                let fileRef = storageRef.child("\(userUID)/\(fileName)")
                
                let downloadTask = fileRef.write(toFile: fileURL) { url, error in
                  if let error = error {
                    // Uh-oh, an error occurred!
                  } else {
                    print("File downloaded")
                  }
                }
                
            } else {
                return
            }
        }
    }
    
    
}
