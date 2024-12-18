//
//  ViewDetailsViewController.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import UIKit

class ViewDetailsViewController: UIViewController {
    
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var sortBtn: UIButton!
    
    var viewModel = AddDetailsViewModel()
    var waterWaveView = WaterWaveProgressBar()
    let dr: TimeInterval = 10.0
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        registerCells()
        progressData()
        viewModel.fetchData()
        viewModel.onDeleteUpdate = {
            self.progressCal()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        progressCal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
//        navigationController?.tabBarController?.tabBar.isHidden = true
//        view.backgroundColor = StyleSheet.Color.containerModal
    }
    
    func progressCal() {
        viewModel.todaysTotal()
        waterWaveView.progress = 0.0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { _ in
            let dr = CGFloat(1.0 / (self.dr/0.01))
            self.waterWaveView.progress += dr
            self.waterWaveView.setupProgress(self.waterWaveView.progress)
            
            if self.waterWaveView.progress >= (self.viewModel.todaysTotalWaterInLiter / 100) {
                self.timer?.invalidate()
                self.timer = nil
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.waterWaveView.percentAnim()
                }
            }
        })
    }
    
    func progressData() {
        progressView.addSubview(waterWaveView)
        waterWaveView.setupProgress(waterWaveView.progress)
        
        NSLayoutConstraint.activate([
            waterWaveView.widthAnchor.constraint(equalToConstant: screenWidth * 0.5),
            waterWaveView.heightAnchor.constraint(equalToConstant: screenWidth * 0.5),
            waterWaveView.centerXAnchor.constraint(equalTo: progressView.centerXAnchor),
            waterWaveView.centerYAnchor.constraint(equalTo: progressView.centerYAnchor)
        ])
    }
    
    func reloadData() {
        if self.viewModel.isfilteredSuccessfully {
            self.viewModel.isfilteredSuccessfully = false
            self.tableView.reloadData()
            showToastMessage(message: "Filtered Successfully")
        }
        
        if self.viewModel.isSavedSuccessfully {
            self.viewModel.isSavedSuccessfully = false
            progressCal()
            self.tableView.reloadData()
            showToastMessage(message: "Saved Successfully")
        }
        
        if self.viewModel.isSortedAscending {
            self.viewModel.isSortedAscending = false
            self.tableView.reloadData()
            showToastMessage(message: "Sorted Successfully")
        }
        
        if self.viewModel.isDeletedSuccessfully {
            self.viewModel.isDeletedSuccessfully = false
            progressCal()
            self.tableView.reloadData()
            showToastMessage(message: "Deleted Successfully")
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: "ViewDetailsTableViewCell", bundle: nil), forCellReuseIdentifier: "ViewDetailsTableViewCell")
    }

    @IBAction func addBtnAction(_ sender: Any) {
        let addVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddDetailsViewController") as! AddDetailsViewController
        self.navigationController?.pushViewController(addVC, animated: true)
    }
    
    
    @IBAction func filterBtnAction(_ sender: Any) {
        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        viewModel.isFilter = true
        filterVC.delegate = self
        filterVC.viewModel.items = viewModel.filterItems
        navigationController?.present(filterVC, animated: true)
    }
    
    @IBAction func sortBtnAction(_ sender: Any) {
        let filterVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as! BottomSheetViewController
        viewModel.isFilter = false
        filterVC.delegate = self
        filterVC.viewModel.items = viewModel.sortItems
        navigationController?.present(filterVC, animated: true)
    }
}

extension ViewDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.listData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ViewDetailsTableViewCell", for: indexPath) as! ViewDetailsTableViewCell
        if let dataVal: WaterInTake = viewModel.listData?[indexPath.row] {
            cell.waterInTakeLabel.text = dataVal.value.toString() != "" ? "\(dataVal.value.toString()) Liter" : "0 Liter"
            if let dateVal = dataVal.timeStamp {
                cell.timeLabel.text = "\(String(describing: dateVal.timeString()))"
                cell.dateLabel.text = String(describing: dateVal).isToday() ? "Today" : "\(String(describing: dateVal.toStringChangeDate()))"
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let deleteRowAction = UIContextualAction(style: .destructive, title: "", handler: { (ac: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            self.viewModel.deleteData(id: self.viewModel.listData?[indexPath.row].id ?? UUID())
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        })
        
        deleteRowAction.image = UIImage(named: "deleteIcon")
        deleteRowAction.backgroundColor = UIColor(named: "c1")
        let action = UISwipeActionsConfiguration(actions: [deleteRowAction])
        action.performsFirstActionWithFullSwipe = false
        return action
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//            let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
//                self.viewModel.deleteData(id: self.viewModel.listData?[indexPath.row].id ?? UUID())
//                self.tableView.deleteRows(at: [indexPath], with: .automatic)
//            }
//            deleteAction.backgroundColor = .red
//            return [deleteAction]
//        }
    
}

extension ViewDetailsViewController: DataPassingDelegate {
    func didReceiveData(_ data: String, _ item: [FilterData]) {
        viewModel.listData = viewModel.listDataCopy
        if viewModel.isFilter {
            viewModel.filterItems = item
            if data == "" {
                viewModel.isfilteredSuccessfully = true
                reloadData()
            } else {
                viewModel.listData = viewModel.filterData(by: data)
                viewModel.isfilteredSuccessfully = true
                reloadData()
            }
        } else {
            viewModel.sortItems = item
            if data == "" {
                viewModel.isSortedAscending = false
            } else {
                viewModel.sortData(byAscending: data == "Ascending order" ? true : false)
                viewModel.isSortedAscending = true
                reloadData()
            }
        }
        
    }
}
