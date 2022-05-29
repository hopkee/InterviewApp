//
//  AssemblyaiAPIManager.swift
//  InterviewApp
//
//  Created by Valya on 25.05.22.
//

import Foundation
import Alamofire

struct UploadedFileURL: Codable {
  let url: String
  
  enum CodingKeys: String, CodingKey {
    case url = "upload_url"
  }
}

struct SubmitedFileResponse: Decodable {
    let id: String
    let language_model: String
    let acoustic_model: String
    let language_code: String
    let status: String
    let audio_url: URL
    let text: String?
    let words: String?
    let utterances: String?
    let confidence: Double?
    let audio_duration: String?
    let punctuate: Bool
    let format_text: Bool
    let dual_channel: String?
    let webhook_url: String?
    let webhook_status_code: String?
    let speed_boost: Bool
    let auto_highlights_result: String?
    let auto_highlights: Bool
    let audio_start_from: String?
    let audio_end_at: String?
    let word_boost: [String?]
    let boost_param: String?
    let filter_profanity: Bool
    let redact_pii: Bool
    let redact_pii_audio: Bool
    let redact_pii_audio_quality: String?
    let redact_pii_policies: String?
    let redact_pii_sub: String?
    let speaker_labels: Bool
    let content_safety: Bool
    let iab_categories: Bool
    let content_safety_labels: SafetyLabels?
    let iab_categories_result: CategoriesResult?
    let language_detection: Bool
    let custom_spelling: String?
    let disfluencies: Bool
    let sentiment_analysis: Bool
    let sentiment_analysis_results: String?
    let auto_chapters: Bool
    let chapters: String?
    let entity_detection: Bool
    let entities: String?
}

struct CheckCompletionResponse: Decodable {
    let id: String
    let language_model: String
    let acoustic_model: String
    let language_code: String
    let status: String
    let audio_url: URL
    let text: String?
    let words: [Word]?
    let utterances: String?
    let confidence: Double?
    let audio_duration: Double?
    let punctuate: Bool
    let format_text: Bool
    let dual_channel: String?
    let webhook_url: String?
    let webhook_status_code: String?
    let speed_boost: Bool
    let auto_highlights_result: String?
    let auto_highlights: Bool
    let audio_start_from: String?
    let audio_end_at: String?
    let word_boost: [String?]
    let boost_param: String?
    let filter_profanity: Bool
    let redact_pii: Bool
    let redact_pii_audio: Bool
    let redact_pii_audio_quality: String?
    let redact_pii_policies: String?
    let redact_pii_sub: String?
    let speaker_labels: Bool
    let content_safety: Bool
    let iab_categories: Bool
    let content_safety_labels: SafetyLabels?
    let iab_categories_result: CategoriesResult?
    let language_detection: Bool
    let custom_spelling: String?
    let disfluencies: Bool
    let sentiment_analysis: Bool
    let sentiment_analysis_results: String?
    let auto_chapters: Bool
    let chapters: String?
    let entity_detection: Bool
    let entities: String?
}

struct Word: Decodable {
    let text: String
    let start: Int
    let end: Int
    let confidence: Double
    let speaker: String?
}

struct SafetyLabels: Decodable {
    let id: String?
}

struct CategoriesResult: Decodable {
    let id: String?
}

final class AssemblyaiAPIManager {
    
    static let shared = AssemblyaiAPIManager()
    
    private init() {}
    
    private let sessionManager: Session = {
        let configuration = URLSessionConfiguration.af.default
        let headers: HTTPHeaders = [
            "authorization" : "19ea64f2d1ed4fd9b4f21cd6cb3effeb",
            "content-type": "application/json"
        ]
        configuration.headers = headers
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 30
        return Session(configuration: configuration)
    }()
    
    func getTextFromAudioFile(_ localFileUrl: URL, handler: @escaping ((String) -> Void)) {
        sendFileToApi(localFileUrl, handler: { [weak self] response in
            let uploadedFileURL = response
            self!.submitFileForProcessing(uploadedFileURL, handler: { [weak self] audioID in
                self!.getTranscription(audioID, handler: { transriptedText in
                    handler(transriptedText)
                })
            })
        })
    }
    
    private func sendFileToApi(_ localFileUrl: URL, handler: @escaping ((String) -> Void)) {
        sessionManager.upload(localFileUrl, to: "https://api.assemblyai.com/v2/upload", method: .post).validate().responseDecodable(of: UploadedFileURL.self) { response in
            guard let responseValue = response.value else { return }
            handler(responseValue.url)
            print("File sended to API, response: \(responseValue.url)")
        }
    }
    
    private func submitFileForProcessing(_ uploadedFileURL: String, handler: @escaping (String) -> Void) {
        let url = "https://api.assemblyai.com/v2/transcript"
        let parameters = [
            "audio_url" : uploadedFileURL
        ]
        sessionManager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default).validate().responseDecodable(of: SubmitedFileResponse.self) { response in
            guard let audioID = response.value?.id else { print("No audio ID"); return }
            handler(audioID)
            print("File submitted for processing: \(audioID)")
        }
    }
 
    
    private func getTranscription(_ audioID: String, handler: @escaping ((String) -> Void)) {
        let url = "https://api.assemblyai.com/v2/transcript/" + audioID
        sessionManager.request(url, method: .get).validate().responseDecodable(of: CheckCompletionResponse.self, completionHandler: { response in
            print(response.value?.status)
                guard let status = response.value?.status else { return }
                if status == "queued" || status == "processing" {
                    DispatchQueue.global().asyncAfter(deadline: .now() + 2) { [weak self] in
                        self!.getTranscription(audioID, handler: handler)
                        print("Transcription in progress: \(audioID)")
                    }
                } else {
                    guard let transcription = response.value?.text else { return }
                    handler(transcription)
                    print("Transcription completed: \(transcription)")
                }
        })
    }
    
}
