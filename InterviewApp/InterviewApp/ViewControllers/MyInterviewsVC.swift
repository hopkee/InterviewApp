//
//  MyInterviewsVC.swift
//  InterviewApp
//
//  Created by Valya on 7.05.22.
//

import UIKit

class MyInterviewsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    let interviewOne = Interview(title: "My first important interview", date: Date(), duration: 2, interviewer: Interviewer(name: "Valentin Velichko", notes: "nil"), notes: "nil")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "InterviewCell", bundle: nil), forCellReuseIdentifier: "InterviewCell")
        tableView.sectionHeaderTopPadding = 0
    }

}

extension MyInterviewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InterviewCell", for: indexPath) as? InterviewCell
        cell!.nameOfInterviewLblOutlet.text = interviewOne.title
        cell!.nameOfIntervieweeOutlet.text = interviewOne.interviewer?.name
        cell!.dateOfInterviewOutlet.text = interviewOne.date.description
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        140
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        7
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .white
        return headerView
    }
    
}


