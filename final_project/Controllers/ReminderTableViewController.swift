//
//  ReminderTableViewController.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-15.
//

import UIKit

class ReminderTableViewController: UITableViewController, AddingReminderDelegateProtocol{

    var allReminders = [Reminder]()
    override func viewDidLoad() {
        super.viewDidLoad()
        allReminders = CoreDateService.shared.getAllReminder()
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allReminders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = allReminders[indexPath.row].medicine
        cell.detailTextLabel?.text = allReminders[indexPath.row].date

        return cell
    }
 
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CoreDateService.shared.deleteOneReminder(toDelete: allReminders[indexPath.row])
            
            allReminders = CoreDateService.shared.getAllReminder()
            tableView.reloadData()
            
        }
    }
    
    func controllerDidFinishWithNewReminder() {
        self.allReminders = CoreDateService.shared.getAllReminder()
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "updateReminder" {
            let selectedIndex = tableView.indexPathForSelectedRow?.row
            let addReminderVC = segue.destination as? AddReminderViewController
            addReminderVC!.reminder = allReminders[selectedIndex!]
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.allReminders = CoreDateService.shared.getAllReminder()
        self.tableView.reloadData()
    }
}
