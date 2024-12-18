//
//  AddTDateTimeTableViewCell.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

protocol AddTDateTimeTableViewCellProtocol: NSObject {
    func enterDate(value: String)
}

class AddTDateTimeTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dateTimeTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    let dateFormatter = DateFormatter()
    weak var delegate: AddTDateTimeTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm a"
        datePicker.datePickerMode = .dateAndTime
//        dateTimeTextField.text = dateFormatter.string(from: datePicker.date)
        dateTimeTextField.text = Date.getCurrentDateAndTime()
        dateTimeTextField.layer.cornerRadius = 8
        dateTimeTextField.layer.borderColor = UIColor(named: "strokeSecondary")?.cgColor
        dateTimeTextField.layer.borderWidth = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func datePickerAction(_ sender: Any) {
//        dateTimeTextField.text = dateFormatter.string(from: (sender as AnyObject).date)
        dateTimeTextField.text = (sender as AnyObject).date?.toStringChangeDate()
        delegate?.enterDate(value: dateTimeTextField.text ?? "")
        dateTimeTextField.endEditing(true)
    }
}
