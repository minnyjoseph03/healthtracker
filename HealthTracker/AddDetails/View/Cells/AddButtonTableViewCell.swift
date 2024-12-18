//
//  AddButtonTableViewCell.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

class AddButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    
    var onAddDetails: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func addBtnAction(_ sender: Any) {
        onAddDetails?()
    }
    
    func setup(isEnable: Bool) {
        if isEnable {
            selectedButton(button: addButton)
        } else {
            unSelectedButton(button: addButton)
        }
    }
    
    private func selectedButton(button: UIButton) {
        button.isEnabled = true
        button.backgroundColor = UIColor(named: "c5")
        button.setTitleColor(UIColor(named: "textWhite"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .bold)
    }

    private func unSelectedButton(button: UIButton) {
        button.isEnabled = false
        button.backgroundColor = UIColor(named: "primaryDisable")
        button.setTitleColor(UIColor(named: "ctaPrimaryDisable"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 19.0, weight: .bold)
    }
}
