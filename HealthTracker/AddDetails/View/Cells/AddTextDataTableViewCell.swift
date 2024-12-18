//
//  AddTextDataTableViewCell.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

protocol AddTextDataTableViewCellProtocol: NSObject {
    func enterInput(value: String)
}

class AddTextDataTableViewCell: UITableViewCell {
    
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: AddTextDataTableViewCellProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        inputTextField.delegate = self
        inputTextField.keyboardType = .decimalPad
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        let button = UIBarButtonItem(title: "Done", style: .plain, target: self,
                                     action: #selector(dismiss))
        toolBar.setItems([button], animated: true)
        toolBar.isUserInteractionEnabled = true
        inputTextField.inputAccessoryView = toolBar
        inputTextField.layer.cornerRadius = 8
        inputTextField.layer.borderColor = UIColor(named: "strokeSecondary")?.cgColor
        inputTextField.layer.borderWidth = 1
    }
    
    @objc func dismiss() {
        inputTextField.endEditing(true)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension AddTextDataTableViewCell: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        delegate?.enterInput(value:textField.text ?? "")
        //        if let text =  as NSString? {
        //
        //        }
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        inputTextField.placeholder = nil
        inputTextField.layer.borderColor = UIColor(named: "strokeprimary1")?.cgColor
//               borderColorView = UIColor(named: "strokeprimary1")
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        inputTextField.layer.borderColor = UIColor(named: "strokeSecondary")?.cgColor
        delegate?.enterInput(value: textField.text ?? "")
        textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        delegate?.enterInput(value: textField.text ?? "")
        inputTextField.resignFirstResponder()
        return true
    }
}

