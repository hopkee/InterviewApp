//
//  MyInterviewsVC.swift
//  InterviewApp
//
//  Created by Valya on 7.05.22.
//

import UIKit


class MyInterviewsVC: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        setData()
    }
    
    
    @IBAction func addInterviewAction(_ sender: UIBarButtonItem) {
        let storyboard = UIStoryboard(name: "InterviewProcess", bundle: nil)
        guard let destVC = storyboard.instantiateViewController(withIdentifier: "addNewInterview") as? PlanNewInterviewVC else { return }
        self.present(destVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        setupUI()
        loadData()
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateData), name: NSNotification.Name(rawValue: "updateInterviews"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setData()
    }
    
    let dbManager = DatabaseManager()
    let currentUserUid = AuthManager.shared.getCurrentUserUid()
    var interviews: [Interview] = []
    var sortedInterviews: [Interview] = []
    
    private func setupUI() {
        tableView.register(UINib(nibName: "InterviewCell", bundle: nil), forCellReuseIdentifier: "InterviewCell")
        tableView.sectionHeaderTopPadding = 0
        segmentControl.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        segmentControl.setTitleTextAttributes([.foregroundColor: CustomColors.getColor(CustomColor.mainBlue)], for: .selected)
    }
    
    private func setData() {
        sortedInterviews = interviews
        switch segmentControl.selectedSegmentIndex {
        case 0:
            sortedInterviews = sortedInterviews.filter() {
                $0.isCompleted == false
            }
            self.tableView.reloadData()
        case 1:
            sortedInterviews = sortedInterviews.filter() {
                $0.isCompleted == true
            }
            self.tableView.reloadData()
        default:
            break
        }
    }
    
    private func loadData() {
        guard let uid = currentUserUid else { return }
        dbManager.getAllInterviews(uid: uid, completion: { [weak self] interviews in
            self!.interviews = interviews
            self!.tableView.delegate = self
            self!.tableView.dataSource = self
            self!.setData()
        })
    }
    
    func updateTableView() {
        loadData()
        tableView.reloadData()
    }
    
    @objc func updateData() {
        updateTableView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "GoToDetailInterview" {
            guard let detailInterviewVC = segue.destination as? DetailInterviewVC else { return }
            guard let index = sender as? Int else { return }
            detailInterviewVC.interview = sortedInterviews[index]
        }
    }

}

extension MyInterviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sortedInterviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewCell", for: indexPath) as? InterviewCell
        cell!.nameOfInterviewLblOutlet.text = sortedInterviews[indexPath.section].title
        cell!.nameOfIntervieweeOutlet.text = sortedInterviews[indexPath.section].intervieweeName
        cell!.dateOfInterviewOutlet.text = ConverterService.dateForTableView(sortedInterviews[indexPath.section].startDate!)
        if let isAudioRecorded = sortedInterviews[indexPath.section].isAudioRecorded {
            if isAudioRecorded {
                cell!.audioIconOutlet.isHidden = false
            } else {
                cell!.audioIconOutlet.isHidden = true
            }
        } else {
            cell!.audioIconOutlet.isHidden = true
        }
        if let _ = sortedInterviews[indexPath.section].transcription {
            cell!.textIconOutlet.isHidden = false
        } else {
            cell!.textIconOutlet.isHidden = true
        }
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailInterview", sender: indexPath.section)
    }
    
}


