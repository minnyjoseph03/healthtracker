//
//  AddDetailsViewModel.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//

import Foundation
import CoreData

enum AddDetailsRows {
    case heading
    case dataInput
    case dateTime
    case dayType
    case addDetailBtn
}

class AddDetailsViewModel {
    
//    private let context: NSManagedObjectContext
    
    var rows: [AddDetailsRows] = [.heading, .dataInput, .dateTime, .addDetailBtn]
    var waterInTake: Double?
    var dateVal: Date = Date.dateFromDateString(str: Date.getCurrentDateAndTime()) ?? Date()
    var waterInTakeData: WaterInTakeData?
    var listData: [WaterInTake]?
    var listDataCopy: [WaterInTake] = []
    var isSavedSuccessfully: Bool = false
    var filterOptions: [TimeOfDay] = [.morning, .afternoon, .evening, .night]
    var filterVal: String = ""
    var isfilteredSuccessfully: Bool = false
    var isSortedAscending: Bool = false
    var isFilter: Bool = false
    var isButtonEnable: Bool = false
    var todaysTotalWaterInLiter: Double = 0.0
    var isDeletedSuccessfully: Bool = false
    
    var onDeleteUpdate: (() -> Void)?
    
//    init(context: NSManagedObjectContext) {
//            self.context = context
//        fetchData()
//        }
    
    var filterItems: [FilterData] = [FilterData(rowTitle: TimeOfDay.morning.rawValue, timeRange: " (6.00 AM - 12.00)", isSelected: false), FilterData(rowTitle: TimeOfDay.afternoon.rawValue, timeRange: " (12.00 PM - 5.00 PM)", isSelected: false), FilterData(rowTitle: TimeOfDay.evening.rawValue, timeRange: " (5.00 PM - 9.00 PM)", isSelected: false), FilterData(rowTitle: TimeOfDay.night.rawValue, timeRange: " (9.00 PM - 6.00 AM)", isSelected: false)]
    var sortItems: [FilterData] = [FilterData(rowTitle: "Ascending order", timeRange: "", isSelected: false), FilterData(rowTitle: "Descending order", timeRange: "", isSelected: false)]
    
    func saveData(data: WaterInTakeData) {
        let waterInTakeData = WaterInTake(context: PersistentStorage.shared.context)
        waterInTakeData.id = data.id
        waterInTakeData.value = data.value
        waterInTakeData.timeStamp = data.timestamp
        waterInTakeData.timeType = data.timeType.rawValue
        PersistentStorage.shared.saveContext()
        isSavedSuccessfully = true
        fetchData()
    }
    
    func fetchData() {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(WaterInTake.fetchRequest()) as? [WaterInTake] else { return }
            listData = result.sorted { $0.timeStamp ?? Date() > $1.timeStamp ?? Date() }
            listDataCopy = listData ?? []
            print(listData ?? [])
        } catch {
            debugPrint("Error")
        }
    }
    
    func deleteData(id: UUID) {
        let fetchRequest: NSFetchRequest<WaterInTake> = WaterInTake.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        if let result = try? PersistentStorage.shared.context.fetch(fetchRequest).first {
            PersistentStorage.shared.context.delete(result)
            PersistentStorage.shared.saveContext()
            isDeletedSuccessfully = true
//             PersistentStorage.shared.saveContext()
            fetchData()
            todaysTotal()
            onDeleteUpdate?()
        }
    }
    
//    private func saveContext() {
//            if context.hasChanges {
//                do {
//                    try context.save()
////                    DispatchQueue.main.async {
////                        
//////                        Toast.show(message: "Successfully saved!", duration: 2.0)
////                    }
//                } catch {
//                    print("Failed to save context: \(error)")
//                }
//            }
//        }
    
    func filterData(by type: String) -> [WaterInTake] {
        if type == "" {
            return listDataCopy
        }
        return listData?.filter { $0.timeType == type } ?? []
    }
    
    func sortData(byAscending ascending: Bool) {
        listData?.sort { ascending ? $0.value < $1.value : $0.value > $1.value }
    }
    
    func todaysTotal() {
        todaysTotalWaterInLiter = 0.0
        for i in 0..<(listData?.count ?? 0) {
            if String(describing: listData?[i].timeStamp ?? Date()).isToday() == true {
                todaysTotalWaterInLiter = todaysTotalWaterInLiter + (listData?[i].value ?? 0.0)
            }
        }
    }
}
