//
//  AddReminderViewController.swift
//  final_project
//
//  Created by Pruthvi Gandhi on 2021-12-15.
//

import UIKit

protocol AddingReminderDelegateProtocol {
    func controllerDidFinishWithNewReminder()
}

class AddReminderViewController: UIViewController {

    var name: String? = nil
    var reminder: Reminder? = nil
    public var delegate: AddingReminderDelegateProtocol?
    @IBOutlet weak var txtMedicine: UITextField!
    @IBOutlet weak var dateTime: UIDatePicker!
    override func viewDidLoad() {
        super.viewDidLoad()
        if(name != nil)
        {
            txtMedicine.text = name
        }
        if(reminder != nil)
        {
            txtMedicine.text = reminder?.medicine
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy, HH:mm"
            let date = dateFormatter.date(from: (reminder?.date)!)
            dateTime.date = date!
        }
    }

    @IBAction func saveBtnClicked(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy, HH:mm"
        let date = dateFormatter.string(from: dateTime.date)
        if(reminder == nil)
        {
            CoreDateService.shared.insertNewReminder(medicine: txtMedicine.text!, date: date)

        }
        else{
            CoreDateService.shared.updateReminder(oldReminder: reminder!, newReminder: txtMedicine.text!, newDate: date)
        }
        delegate?.controllerDidFinishWithNewReminder()
        _ = navigationController?.popViewController(animated: true)
    }
}
