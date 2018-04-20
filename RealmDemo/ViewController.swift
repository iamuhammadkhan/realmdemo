//
//  ViewController.swift
//  RealmDemo
//
//  Created by MuhammadKhan on 4/18/18.
//  Copyright © 2018 MuhammadKhan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    let pending = DBManager.shared.getItemsFromDB()
    let completed = DBManager.shared.getCompletedFromDB()
    let deleted = DBManager.shared.getDeletedFromDB()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Pending"
        case 1:
            return "Completed"
        default:
            return "Deleted"
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return pending.count
        case 1:
            return completed.count
        default:
            return deleted.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = pending[indexPath.row].note
        case 1:
            cell.textLabel?.text = completed[indexPath.row].note
        default:
            cell.textLabel?.text = deleted[indexPath.row].note
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        if indexPath.section == 0 {
            let complete = UIContextualAction(style: .normal, title: "Complete") { (action, view, nil) in
                let completed = Completed()
                completed.ID = self.pending[indexPath.row].ID
                completed.note = self.pending[indexPath.row].note
                DBManager.shared.addCompleted(object: completed)
                DBManager.shared.deleteItemFromDb(object: self.pending[indexPath.row])
                self.tableView.reloadData()
                print("Completed")
            }
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                let deleted = Deleted()
                deleted.ID = self.pending[indexPath.row].ID
                deleted.note = self.pending[indexPath.row].note
                DBManager.shared.addDeleted(object: deleted)
                DBManager.shared.deleteItemFromDb(object: self.pending[indexPath.row])
                self.tableView.reloadData()
                print("Deleted")
            }
            return UISwipeActionsConfiguration(actions: [complete, delete])
        } else if indexPath.section == 1 {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                let deleted = Deleted()
                deleted.ID = self.completed[indexPath.row].ID
                deleted.note = self.completed[indexPath.row].note
                DBManager.shared.addDeleted(object: deleted)
                DBManager.shared.deleteCompletedFromDb(object: self.completed[indexPath.row])
                self.tableView.reloadData()
                print("Deleted")
            }
            return UISwipeActionsConfiguration(actions: [delete])
        } else {
            let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, nil) in
                DBManager.shared.deleteDeletedFromDb(object: self.deleted[indexPath.row])
                self.tableView.reloadData()
                print("Deleted")
            }
            return UISwipeActionsConfiguration(actions: [delete])
        }
    }
    
    @IBAction func addBtn(_ sender: Any) {
        performSegue(withIdentifier: "SecondVC", sender: nil)
    }
}
