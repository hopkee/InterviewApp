//
//  IntervieweesTVC.swift
//  InterviewApp
//
//  Created by Валентин Величко on 11.05.22.
//

import UIKit

final class IntervieweesTVC: UITableViewController {
    
    
    @IBAction func addNewInterveweeAction(_ sender: UIBarButtonItem) {
        showAlert()
    }
    
    let searchController = UISearchController()
    let dbManager = DatabaseManager()
    let currentUserUid = AuthManager.shared.getCurrentUserUid()
    
    var interviewees: [Interviewee] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setUP()
        loadData()
    }
    
    private func loadData() {
        guard let uid = currentUserUid else { return }
        dbManager.getAllInterviewees(uid: uid, completion: { [weak self] interviewees in
            self!.interviewees = interviewees
            self!.tableView.reloadData()
        })
    }
    
    private func showAlert() {
        
        var inputName: UITextField?
        var inputEmail: UITextField?
        var inputPhone: UITextField?
        var inputNotes: UITextField?
        
        let alertController = UIAlertController(title: "Add new interviewee", message: nil, preferredStyle: .alert)
        let actionCancel = UIAlertAction(title: "Cancel", style: .cancel)
        let actionAdd = UIAlertAction(title: "Add", style: .default, handler: { _ in
            let name = inputName?.text
            let email = inputEmail?.text
            let phone = inputPhone?.text
            let notes = inputNotes?.text
            
            let interviewee = Interviewee(name: name!, notes: notes!, phone: phone!, email: email!)
            self.interviewees.append(interviewee)
            guard let uid = self.currentUserUid else { return }
            self.dbManager.createInterviewee(uid: uid,interviewee)
            let indexpath = IndexPath(row: self.interviewees.count - 1, section: 0)
            self.tableView.insertRows(at: [indexpath], with: .automatic)
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "Name"
            inputName = textField
        })
        
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "email"
            inputEmail = textField
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "phone"
            inputPhone = textField
        })
        alertController.addTextField(configurationHandler: { textField in
            textField.placeholder = "any other notes"
            inputNotes = textField
        })
        alertController.addAction(actionCancel)
        alertController.addAction(actionAdd)
        present(alertController, animated: true)
    }

    // MARK: - Table view data source

    private func setUP() {
        searchController.searchBar.searchTextField.backgroundColor = .white
        navigationItem.searchController = searchController
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interviewees.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IntervieweeCell", for: indexPath) as! IntervieweeCell
        cell.intervieweeName.text = interviewees[indexPath.row].name
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
