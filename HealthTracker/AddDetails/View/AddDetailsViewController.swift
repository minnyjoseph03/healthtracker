//
//  AddDetailsViewController.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit
import CoreData

class AddDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = AddDetailsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        tableView.dataSource = self
        tableView.delegate = self
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        debugPrint(path.first)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
//        navigationController?.tabBarController?.tabBar.isHidden = true
//        view.backgroundColor = StyleSheet.Color.containerModal
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib(nibName: "AddTextDataTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTextDataTableViewCell")
        tableView.register(UINib(nibName: "AddButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "AddButtonTableViewCell")
        tableView.register(UINib(nibName: "AddTDateTimeTableViewCell", bundle: nil), forCellReuseIdentifier: "AddTDateTimeTableViewCell")
    }
    
    func addBtnEnabled() {
        if String(describing:viewModel.waterInTake) == "", String(describing: viewModel.dateVal) == "" {
            viewModel.isButtonEnable = false
        } else {
            viewModel.isButtonEnable = true
        }
        self.tableView.reloadRows(at: [IndexPath(row: 0, section: 3)], with: .automatic)
    }
}

extension AddDetailsViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.rows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.rows[section] {
        case .heading:
            return 1
        case .dataInput:
            return 1
        case .addDetailBtn:
            return 1
        case .dateTime:
            return 1
        case .dayType:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.rows[indexPath.section] {
        case .heading:
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.headerLabel.text = "Add Details"
            return cell
        case .dataInput:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTextDataTableViewCell", for: indexPath) as! AddTextDataTableViewCell
            cell.titleLabel.text = "Water Taken(In Liter)"
            cell.inputTextField.placeholder = "Enter the Value"
//            cell.inputTextField.keyboardType = .numbersAndPunctuation
            cell.inputTextField.text = (String(describing: viewModel.waterInTake ?? 0.0) == "0.0") ? "" : String(describing: viewModel.waterInTake ?? 0.0)
            cell.delegate = self
            return cell
        case .addDetailBtn:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddButtonTableViewCell", for: indexPath) as! AddButtonTableViewCell
            cell.onAddDetails = { [weak self] in
                self?.viewModel.waterInTakeData = WaterInTakeData(id: UUID(), value: self?.viewModel.waterInTake ?? 0.0, timestamp: self?.viewModel.dateVal ?? Date())
                self?.viewModel.saveData(data: self?.viewModel.waterInTakeData ?? WaterInTakeData(id: UUID(), value: 0.0, timestamp: Date()))
                let viewVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewDetailsViewController") as! ViewDetailsViewController
                self?.navigationController?.pushViewController(viewVC, animated: true)
            }
            cell.setup(isEnable: viewModel.isButtonEnable)
            return cell
        case .dateTime:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTDateTimeTableViewCell", for: indexPath) as! AddTDateTimeTableViewCell
            cell.titleLabel.text = "Date and Time"
            cell.dateTimeTextField.placeholder = "Select Date and Time"
            cell.delegate = self
            return cell
        case .dayType:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddTextDataTableViewCell", for: indexPath) as! AddTextDataTableViewCell
            cell.titleLabel.text = "Day"
            cell.inputTextField.placeholder = "Enter the Value"
            return cell
        }
    }
    
    
}
extension AddDetailsViewController: AddTextDataTableViewCellProtocol {
    func enterInput(value: String) {
        viewModel.waterInTake = Double(value)
        addBtnEnabled()
    }
}

extension AddDetailsViewController: AddTDateTimeTableViewCellProtocol {
    func enterDate(value: String) {
        viewModel.dateVal = Date.dateFromDateString(str: value) ?? Date()
    }
}
