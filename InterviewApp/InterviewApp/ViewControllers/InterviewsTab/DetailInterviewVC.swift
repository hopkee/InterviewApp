//
//  DetailInterviewVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 7.05.22.
//

import UIKit
import AVFoundation

class DetailInterviewVC: UIViewController {
    
    @IBOutlet weak var interviewTitleOutlet: UILabel!
    @IBOutlet weak var checkboxOutlet: UIImageView!
    @IBOutlet weak var intervieweeLblOutlet: UILabel!
    @IBOutlet weak var interviewDateOutlet: UILabel!
    @IBOutlet weak var durationOutlet: UILabel!
    @IBOutlet weak var durationStackViewOutlet: UIStackView!
    @IBOutlet weak var segmentControlOutlet: UISegmentedControl!
    @IBOutlet weak var tableViewOutlet: UITableView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var playBtnOutlet: UIButton!
    @IBOutlet weak var heightOfBlueView: NSLayoutConstraint!
    @IBOutlet weak var whiteView: UIView!
    
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        setupSegmentControl(sender)
    }
    
    @IBAction func playBtnAction(_ sender: UIButton) {
        if !(isAudioPlaing) {
            playBtnOutlet.configuration?.image = UIImage(systemName: "stop")
            let directoryURL = FileManager.default.urls(for: FileManager.SearchPathDirectory.documentDirectory, in:
                        FileManager.SearchPathDomainMask.userDomainMask).first
            let audioFileName = interview!.id + ".m4a"
            let audioFileURL = directoryURL!.appendingPathComponent(audioFileName)
            audioPlayer = try? AVAudioPlayer(contentsOf: audioFileURL)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isAudioPlaing = true
        } else {
            audioPlayer?.stop()
            isAudioPlaing = false
            playBtnOutlet.configuration?.image = UIImage(systemName: "waveform.and.mic")
        }
    }
    
    
    @IBAction func deleteBtnAction(_ sender: UIButton) {
    }
    
    var interview: Interview?
    var isAudioPlaing: Bool = false
    var audioPlayer: AVAudioPlayer?
    var cloudStorage = CloudStorageManager()
    var currentUserUID = AuthManager.shared.getCurrentUserUid()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSegmentControl(nil)
        cloudStorage.downloadFileIfNeeded(userUID: currentUserUID!, interviewID: interview!.id)
        tableViewOutlet.delegate = self
        tableViewOutlet.dataSource = self
    }
    
    private func setupUI() {
        interviewTitleOutlet.text = interview?.title
        intervieweeLblOutlet.text = interview?.intervieweeName
        interviewDateOutlet.text = ConverterService.dateForTableView((interview?.startDate)!)
        if interview!.isCompleted {
            durationOutlet.text = interview?.duration
            checkboxOutlet.isHidden = false
            durationStackViewOutlet.isHidden = false
        } else {
            checkboxOutlet.isHidden = true
            durationStackViewOutlet.isHidden = true
            heightOfBlueView.constant -= 30
        }
        if let _ = interview?.transcription {
            segmentControlOutlet.isHidden = false
        }
        if let isAudioRecorded = interview?.isAudioRecorded {
            isAudioRecorded ? (playBtnOutlet.isHidden = false) : (playBtnOutlet.isHidden = true)
        } else {
            playBtnOutlet.isHidden = true
        }
        tableViewOutlet.layer.borderWidth = 1
        tableViewOutlet.layer.borderColor = CustomColors.getColor(CustomColor.mainBlue).cgColor
        tableViewOutlet.layer.cornerRadius = 15
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CustomColors.getColor(CustomColor.mainBlue).cgColor
        textView.layer.cornerRadius = 15
        whiteView.layer.cornerRadius = 15
    }
    
    private func setupSegmentControl(_ sender: UISegmentedControl?) {
        
        if interview?.transcription == nil {
            segmentControlOutlet.isHidden = true
        } else {
            segmentControlOutlet.isHidden = false
        }
        
        switch !(sender == nil) ? (sender!.selectedSegmentIndex) : (segmentControlOutlet.selectedSegmentIndex) {
            case 0:
                tableViewOutlet.isHidden = false
                textView.isHidden = true
            case 1:
                tableViewOutlet.isHidden = true
                textView.isHidden = false
            default:
                break
            }
    }
}
    
extension DetailInterviewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        (interview?.questions!.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "questionInterviewDetailViewCell")
        var configuration = cell.defaultContentConfiguration()
        configuration.text = interview?.questions![indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
    
}

extension DetailInterviewVC: AVAudioPlayerDelegate {
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        playBtnOutlet.configuration?.image = UIImage(systemName: "waveform.and.mic")
        }
    
}
