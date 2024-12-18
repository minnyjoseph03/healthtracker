//
//  ViewDetailsTableViewCell.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

class ViewDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var waterInTakeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bacgroundView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bacgroundView.layer.masksToBounds = true
        bacgroundView.layer.cornerRadius = 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
