//
//  DetailIntervieweeVC.swift
//  InterviewApp
//
//  Created by Valya on 20.05.22.
//

import UIKit

class DetailIntervieweeVC: UIViewController {
    
    @IBOutlet weak var nameLblOutlet: UILabel!
    @IBOutlet weak var phoneLblOutlet: UILabel!
    @IBOutlet weak var emailLblOultet: UILabel!
    
    @IBOutlet weak var stackViewContacts: UIStackView!
    
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func callBtnAction(_ sender: CustomButtons) {
        guard let number = interviewee?.phone,
                let numberURL = URL(string: "tel://" + number) else { return }
        UIApplication.shared.open(numberURL)
    }
    
    @IBAction func emailBtnAction(_ sender: CustomButtons) {
        guard let email = interviewee?.email,
              let emailURL = URL(string: "mailto:" + email) else { return }
        UIApplication.shared.open(emailURL)
    }
    
    var interviewee: Interviewee?


    override func viewDidLoad() {
        super.viewDidLoad()
//        textView.delegate = self
        setupUI()
    }
    
    private func setupUI() {
        nameLblOutlet.text = interviewee?.name
        phoneLblOutlet.text = interviewee?.phone
        emailLblOultet.text = interviewee?.email
        textView.text = interviewee?.notes
        textView.layer.borderWidth = 1
        textView.layer.borderColor = CustomColors.getColor(CustomColor.mainBlue).cgColor
        textView.layer.cornerRadius = 15
    }

}

//extension DetailIntervieweeVC: UITextViewDelegate {
//
//    override func textViewDidChange(_ textView: UITextView) {
//        <#code#>
//    }
//
//}
