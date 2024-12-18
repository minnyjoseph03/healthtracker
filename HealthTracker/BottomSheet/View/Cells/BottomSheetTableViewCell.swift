//
//  BottomSheetTableViewCell.swift
//  HealthTracker
//
//  Created by Minny Joseph on 17/12/24.
//

import UIKit

protocol BottomSheetTableViewCellProtocol: NSObject {
    func filterCriteriaSelection(cell: BottomSheetTableViewCell)
}

class BottomSheetTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var filterCriteriaBtn: UIButton!
    @IBOutlet weak var filterCriteriaTitleLabel: UILabel!
    @IBOutlet weak var filterCriteriaImageView: UIImageView!

    weak var delegate: BottomSheetTableViewCellProtocol?

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        filterCriteriaTitleLabel.font = UIFont(name: "NotoSans-Medium", size: 14)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction
    private func FilterCriteriaBtnAction(_ sender: UIButton) {
        delegate?.filterCriteriaSelection(cell: self)
    }

    private func setupUI() {
        backgroundColor = UIColor(named: "c1")
        filterCriteriaTitleLabel.textColor = UIColor(named: "c6")
        iconImage.isHidden = true
    }

}

