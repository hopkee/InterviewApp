//
//  AddNewInterviewVC.swift
//  InterviewApp
//
//  Created by Valya on 19.04.22.
//

import UIKit

protocol PlanNewInterviewVCDelegate: AnyObject {
    func updateSelectedInterviewee(interviewee: Interviewee)
}

protocol SelectDateDelegate: AnyObject {
    func updateSelectedDate(date: Date)
}

class PlanNewInterviewVC: UIViewController, PlanNewInterviewVCDelegate, SelectDateDelegate {
    
    @IBOutlet weak var selectIntervieweeBtnOutlet: CustomButtons!
    @IBOutlet weak var dateSelectBtnOutlet: CustomButtons!
    @IBOutlet weak var questionsStackViewOutlet: UIStackView!
    @IBOutlet weak var questionTFOutlet: UITextField!
    @IBOutlet weak var notesTFOutlet: UITextField!
    @IBOutlet weak var interviewTitleTFOutlet: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addInterviewBtnOutlet: CustomButtons!
    
    
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    
    @IBAction func addInterviewBtnAction(_ sender: CustomButtons) {
        if let titleInterview = selectedTitle,
            let startDate = selectedDate {
            let interview = Interview(title: titleInterview, startDate: ConverterService.dateConvertToString(date: startDate), isCompleted: false, intervieweeName: selectedInterviewee?.name, questions: selectedQuestions, notes: selectedNotes)
            dbManager.createInterview(uid: currentUserUid!, interview)
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "updateInterviews"), object: nil)
        dismiss(animated: true)
    }
    
    
    @IBAction func addQuestionsBtnAction(_ sender: UIButton) {
        questionsStackViewOutlet.isHidden = false
    }
    
    
    @IBAction func closeBtnAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    @IBAction func selectIntervieweeBtnAction(_ sender: CustomButtons) {
        let selectIntervieweeVC = SelectIntervieweeModalVC()
        selectIntervieweeVC.modalPresentationStyle = .overCurrentContext
        selectIntervieweeVC.interviewees = interviewees
        selectIntervieweeVC.delegate = self
        self.present(selectIntervieweeVC, animated: false)
        selectIntervieweeBtnOutlet.setCustomTitle(interviewees![0].name)
        selectedInterviewee = interviewees![0]
    }
    
    @IBAction func dateSelectBtnAction(_ sender: CustomButtons) {
        let selectDateVC = SelectDateModalVC()
        selectDateVC.modalPresentationStyle = .overCurrentContext
        selectDateVC.delegate = self
        self.present(selectDateVC, animated: false)
        dateSelectBtnOutlet.setCustomTitle(dateConverToString(date: Date())!)
        selectedDate = Date()
    }
    
    var interviewees: [Interviewee]?
    var selectedTitle: String?
    var selectedInterviewee: Interviewee?
    var selectedDate: Date?
    var selectedQuestions: [String] = [] {
        didSet {
            selectedQuestions != [] ? (tableView.isHidden = false) : (tableView.isHidden = true)
        }
    }
    var selectedNotes: String?
    
    let currentUserUid = AuthManager.shared.getCurrentUserUid()
    let dbManager = DatabaseManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        questionTFOutlet.delegate = self
        interviewTitleTFOutlet.delegate = self
        notesTFOutlet.delegate = self
        self.hideKeyboardWhenTappedAround() 
    }
    
    private func setupUI() {
        questionsStackViewOutlet.isHidden = true
    }
    
    private func loadData() {
        guard let uid = currentUserUid else { return }
        dbManager.getAllInterviewees(uid: uid, completion: { [weak self] interviewees in
            self!.interviewees = interviewees
        })
    }
    
    func updateSelectedInterviewee(interviewee: Interviewee) {
        selectIntervieweeBtnOutlet.setCustomTitle(interviewee.name)
        selectedInterviewee = interviewee
    }
    
    func updateSelectedDate(date: Date) {
        guard let convertedDate = dateConverToString(date: date) else { return }
        dateSelectBtnOutlet.setCustomTitle(convertedDate)
        selectedDate = date
    }
    
    private func dateConverToString(date: Date) -> String? {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let currentYearComponent = Calendar.current.dateComponents([.year], from: Date())
        if let year = components.year,
           let month = components.month,
           let day = components.day,
           let hour = components.hour,
           let minute = components.minute,
           let currentYear = currentYearComponent.year {
            if year == currentYear {
                return "\(day).\(month<10 ? "0" : "")\(month) at \(hour):\(minute)"
            } else {
                return "\(day).\(month<10 ? "0" : "")\(month).\(year) at \(hour):\(minute)"
            }
        }
        return nil
    }

}

extension PlanNewInterviewVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        !(selectedQuestions.isEmpty) ? selectedQuestions.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "questionCell")
        var configuration = cell.defaultContentConfiguration()
        configuration.text = selectedQuestions[indexPath.row]
        cell.contentConfiguration = configuration
        return cell
    }
    
}

extension PlanNewInterviewVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 1:
            guard let enteredTitle = textField.text else { return false }
            selectedTitle = enteredTitle
            return true
        case 2:
            guard let enteredQuestion = textField.text else { return false }
            selectedQuestions.insert(enteredQuestion, at: 0)
            let index = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [index], with: .automatic)
            tableView.layoutIfNeeded()
            tableViewHeight.constant = tableView.contentSize.height
            questionTFOutlet.text = ""
            return true
        case 3:
            guard let enteredNotes = textField.text else { return false }
            selectedNotes = enteredNotes
            return true
        default:
            return true
        }
    }
    
}
