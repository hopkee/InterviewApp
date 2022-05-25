//
//  InterviewInProcessVC.swift
//  InterviewApp
//
//  Created by Valya on 23.05.22.
//

import UIKit
import AVFoundation

final class InterviewInProgressVC: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var interviewTitleOutlet: UILabel!
    @IBOutlet weak var intervieweeNameOutlet: UILabel!
    @IBOutlet weak var durationOutlet: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var notesOutlet: UITextView!
    @IBOutlet weak var micBtnOutlet: UIButton!
    @IBOutlet weak var stopBtnOutlet: UIButton!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var whiteView: UIView!
    
    
    @IBAction func micBtnAction(_ sender: UIButton) {
        toggleRecordAudioBtnState()
        toggleAudioRecord()
        isRecordingAudio.toggle()
        isAudioRecorded = true
    }
    
    @IBAction func stopBtnAction(_ sender: UIButton)  {
        timer?.invalidate()
        stopRecording()
        interview?.duration = durationOutlet.text
        interview?.isCompleted = true
        isAudioRecorded ? (interview?.isAudioRecorded = true) : (interview?.isAudioRecorded = false)
        cloudStorage.uploadFile(userUID: currentUserUid!, interviewID: interview!.id, localFileUrl: soundURL)
        dbManager.createInterview(uid: currentUserUid!, interview!)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateInterviews"), object: nil)
        dismiss(animated: true)
    }
    
    let cloudStorage = CloudStorageManager()
    let currentUserUid = AuthManager.shared.getCurrentUserUid()
    let dbManager = DatabaseManager()
    var audioRecorder: AVAudioRecorder?
    var soundURL: URL!
    var isRecordingAudio: Bool = false
    var interview: Interview?
    var timerSecondsCounter = 0
    var interviewDuration: String?
    var isAudioRecorded: Bool = false
    weak var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        setupUI()
        checkMicrophoneAccess({ [weak self] in
            self!.startTimer()
        })
        let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                    FileManager.SearchPathDomainMask.userDomainMask).first
        let audioFileName = interview!.id + ".m4a"
        let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
        soundURL = audioFileURL
        
        // Setup audio session
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category(rawValue: AVAudioSession.Category.playAndRecord.rawValue), mode: .default)
        } catch _ {
        }
        
        // Define the recorder setting
        let recorderSetting = [AVFormatIDKey: NSNumber(value: kAudioFormatMPEG4AAC as UInt32),
                                       AVSampleRateKey: 44100.0,
                                       AVNumberOfChannelsKey: 2]
                
        audioRecorder = try? AVAudioRecorder(url: audioFileURL, settings: recorderSetting)
        audioRecorder?.delegate = self
        audioRecorder?.isMeteringEnabled = true
        audioRecorder?.prepareToRecord()
        
    }
    
    private func setupUI() {
        interviewTitleOutlet.text = interview?.title
        intervieweeNameOutlet.text = interview?.intervieweeName
        notesOutlet.text = interview?.notes
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = CustomColors.getColor(CustomColor.lightBlue).cgColor
        tableView.layer.cornerRadius = 15
        whiteView.layer.cornerRadius = 15
        durationOutlet.text = timeFormatted(timerSecondsCounter)
        micBtnOutlet.configuration?.background.backgroundColor = CustomColors.getColor(CustomColor.red)
        micBtnOutlet.configuration?.image = UIImage(systemName: "mic.slash")
    }
    
    private func toggleAudioRecord() {
        
        if isRecordingAudio {
            if let recorder = audioRecorder {
                recorder.pause()
                print("Recording stopped")
            }
        } else {
            if let recorder = audioRecorder {
                        if !recorder.isRecording {
                            let audioSession = AVAudioSession.sharedInstance()
                            
                            do {
                                try audioSession.setActive(true)
                            } catch _ {
                            }
                            
            // Start recording
                            recorder.record()
                            print("Recording started")
                        }
            }
        }
    }
    
    private func stopRecording() {
        if let recorder = audioRecorder {
            if recorder.isRecording {
                audioRecorder?.stop()
                    let audioSession = AVAudioSession.sharedInstance()
                        do {
                            try audioSession.setActive(false)
                            print("Recording stopped")
                        } catch _ {
                        }
            }
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
    }
    
    @objc private func fireTimer() {
        timerSecondsCounter += 1
        durationOutlet.text = timeFormatted(timerSecondsCounter)
    }
    
    private func toggleRecordAudioBtnState() {
        if isRecordingAudio {
            micBtnOutlet.configuration?.background.backgroundColor = CustomColors.getColor(CustomColor.red)
            micBtnOutlet.configuration?.image = UIImage(systemName: "mic.slash")
        } else {
            micBtnOutlet.configuration?.background.backgroundColor = CustomColors.getColor(CustomColor.mainBlue)
            micBtnOutlet.configuration?.image = UIImage(systemName: "mic")
        }
    }
    
    private func checkMicrophoneAccess(_ handler: (() -> Void)?) {
        
        // Check Microphone Authorization
        switch AVAudioSession.sharedInstance().recordPermission {
            
        case AVAudioSession.RecordPermission.granted:
            print(#function, "Microphone Permission Granted")
            if let handler = handler {
                handler()
            }
            break
            
        case AVAudioSession.RecordPermission.denied:
            // Dismiss Keyboard (on UIView level, without reference to a specific text field)
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            
            let alertVC = UIAlertController(title: "Microphone Error!", message: "Interview App is Not Authorized to Access the Microphone!", preferredStyle: .alert)
            
            func openSettings(alert: UIAlertAction!) {
                DispatchQueue.main.async {
                    if let url = URL.init(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            }
            // Left hand option (default color in PMAlertAction.swift)
            alertVC.addAction(UIAlertAction(title: "Settings", style: .default, handler: openSettings))
        
            // Right hand option (default color grey)
            alertVC.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            
            self.present(alertVC, animated: true, completion: nil)
            return
            
        case AVAudioSession.RecordPermission.undetermined:
            print("Request permission here")
            // Dismiss Keyboard (on UIView level, without reference to a specific text field)
            UIApplication.shared.sendAction(#selector(UIView.endEditing(_:)), to:nil, from:nil, for:nil)
            
            AVAudioSession.sharedInstance().requestRecordPermission({(granted) in
                // Handle granted
                if granted {
                    print(#function, " Now Granted")
                    if let handler = handler {
                        handler()
                    }
                } else {
                    print("Pemission Not Granted")
                    
                } // end else
            })
        @unknown default:
            print("ERROR! Unknown Default. Check!")
        } // end switch
        
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
            let seconds: Int = totalSeconds % 60
            let minutes: Int = (totalSeconds / 60) % 60
            let hours: Int = totalSeconds / 3600
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }

}

extension InterviewInProgressVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interview!.questions?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "questionInProgressCell")
        var configuration = cell.defaultContentConfiguration()
        configuration.text = interview?.questions![indexPath.row]
        cell.contentConfiguration = configuration
        tableViewHeight.constant = tableView.contentSize.height
        return cell
    }
    
}
