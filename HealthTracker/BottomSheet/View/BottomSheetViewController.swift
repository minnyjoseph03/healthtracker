//
//  BottomSheetViewController.swift
//  HealthTracker
//
//  Created by Minny Joseph on 17/12/24.
//

import UIKit

class BottomSheetViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet weak var bgDismissView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var swipeDownView: UIView!
    @IBOutlet weak var containerViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!

    // MARK: - Properties

    var viewModel: BottomSheetViewModel = BottomSheetViewModel()
    weak var delegate: DataPassingDelegate?

    // MARK: - Views Life Cycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        containerView.backgroundColor = UIColor(named: "c1")
        tableView.backgroundColor = UIColor(named: "c1")
        blurrEffect()
        registerCells()
        tapGesture()
    }
}

   // MARK: - Methods

extension BottomSheetViewController {
    
    private func blurrEffect() {
        swipeDownView.layer.cornerRadius = swipeDownView.frame.height / 2
        containerView.layer.cornerRadius = 16
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        containerView.clipsToBounds = true
        bgDismissView.backgroundColor = UIColor(named: "c2")
        bgDismissView.alpha = 0.6

    }

    private func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedOnBgView))
        bgDismissView.isUserInteractionEnabled = true
        bgDismissView.addGestureRecognizer(tap)
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "BottomSheetTableViewCell", bundle: nil), forCellReuseIdentifier: "BottomSheetTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        containerViewHeightConstraint.constant = CGFloat((viewModel.items.count) * 46) + 60
    }

    @objc
    func tappedOnBgView() {
        delegate?.didReceiveData(viewModel.filterVal, viewModel.items)
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension BottomSheetViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "BottomSheetTableViewCell", for: indexPath) as! BottomSheetTableViewCell
        cell.filterCriteriaTitleLabel.text = viewModel.items[indexPath.row].rowTitle + (viewModel.items[indexPath.row].timeRange ?? "")
        cell.delegate = self
        if viewModel.items[indexPath.row ].isSelected {
            cell.filterCriteriaImageView.image = UIImage(named: "checked")
        } else {
            cell.filterCriteriaImageView.image = UIImage(named: "checkbox_empty")
        }
        return cell
    }
}

extension BottomSheetViewController: BottomSheetTableViewCellProtocol {
    func filterCriteriaSelection(cell: BottomSheetTableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else {
            return
        }
        print(indexPath.row)
        for i in 0..<viewModel.items.count {
            if indexPath.row == i {
                viewModel.items[indexPath.row].isSelected.toggle()
            } else {
                viewModel.items[i].isSelected = false
            }
        }
//        viewModel.items[indexPath.row].isSelected.toggle()
        viewModel.filterVal = viewModel.items[indexPath.row].isSelected == true ? viewModel.items[indexPath.row].rowTitle : ""
        tableView.reloadData()
    }
}

