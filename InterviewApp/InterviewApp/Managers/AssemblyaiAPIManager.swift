//
//  AssemblyaiAPIManager.swift
//  InterviewApp
//
//  Created by Valya on 25.05.22.
//

import Foundation
import Alamofire

struct responseOfUploadingFileToAPI: Decodable {
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case url = "upload_url"
  }
}

final class AssemblyaiAPIManager {
    
    func getTranscription(_ localFileUrl: URL, handler: @escaping ((String) -> Void)) {
        
        var urlOnServer: String = ""
        
        sendFileToApi(localFileUrl, handler: { response in
            urlOnServer = response
        })
        
        
        
    }
    
    private func sendFileToApi(_ localFileUrl: URL, handler: @escaping ((String) -> Void)) {
        let headers: HTTPHeaders = [
            "authorization" : "19ea64f2d1ed4fd9b4f21cd6cb3effeb",
            "content-type": "application/json"
        ]
        AF.upload(localFileUrl, to: "https://api.assemblyai.com/v2/upload", method: .post, headers: headers).validate().responseDecodable(of: responseOfUploadingFileToAPI.self) { response in
            guard let responseValue = response.value else { return }
            print(response)
            print("DATA ARRIVED")
            handler(responseValue.url)
        }
    }
    
}
