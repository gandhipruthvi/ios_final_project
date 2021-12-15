//
//  ViewController.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-11.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var apiResults = [Info]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension
    }

    @IBAction func searchBtnClicked(_ sender: Any) {
        print("Button clicked")
        ServiceController.shared.getDrugInfo(drug: txtSearch.text!) { resultsFromAPI in
            // access main thread to update the table
            DispatchQueue.main.async {
                self.apiResults = resultsFromAPI
                print(self.apiResults)
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return apiResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustomCell
        let item = apiResults[indexPath.row]
  
        cell.txtInfo.text += "Product NDC: "+item.product_ndc
        cell.txtInfo.text += "\nGeneric Name: "+item.generic_name
        cell.txtInfo.text += "\nLabeler Name: "+item.labeler_name
        cell.txtInfo.text += "\nActive Ingredients: ["
        for item in item.active_ingredients {
            cell.txtInfo.text += "\n{ Name: " + item.name
            cell.txtInfo.text += "\n Strength: " + item.strength + "}"
        }
        cell.txtInfo.text += "\n]"
        cell.txtInfo.text += "\nDosage Form: "+item.dosage_form
        cell.txtInfo.text += "\nProduct Type: "+item.product_type
        var frame = tableView.frame
        frame.size.height = tableView.contentSize.height
        tableView.frame = frame
        tableView.layoutIfNeeded()
        tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height).isActive = true
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nameReminder" {
            let selectedIndex = tableView.indexPathForSelectedRow?.row
            let addReminderVC = segue.destination as? AddReminderViewController
            addReminderVC!.name = apiResults[selectedIndex!].generic_name
        }
    }
}

