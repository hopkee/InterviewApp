//
//  CalendarVC.swift
//  InterviewApp
//
//  Created by Valya on 19.04.22.
//

import UIKit

class CalendarVC: UIViewController {
    
    @IBOutlet weak var calendarView: UIDatePicker!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func calendarViewAction(_ sender: UIDatePicker) {
        pickedDate = ConverterService.convertDateForCalendar(sender.date)
        filterInterviews()
    }
    
    var interviews: [Interview]?
    var sortedInterviews: [Interview]?
    var selectedDate: Date?
    let currentUserUid = AuthManager.shared.getCurrentUserUid()
    let dbManager = DatabaseManager()
    var pickedDate: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
    private func setupUI() {
        tableView.layer.borderWidth = 1
        tableView.layer.borderColor = CustomColors.getColor(CustomColor.mainBlue).cgColor
        tableView.layer.cornerRadius = 15
    }
    
    private func loadData() {
        guard let uid = currentUserUid else { return }
        dbManager.getAllInterviews(uid: uid, completion: { [weak self] interviews in
            self!.interviews = interviews
            self!.tableView.reloadData()
        })
    }
    
    private func filterInterviews() {
        let interviews = self.interviews
        sortedInterviews = interviews?.filter { $0.startDate!.contains(pickedDate!) }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        tableView.reloadData()
    }

}

extension CalendarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sortedInterviews!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "intervieCellInCalendar")
        var configuration = cell.defaultContentConfiguration()
        configuration.text = sortedInterviews![indexPath.row].title
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}
