//
//  BottomSheetViewModel.swift
//  HealthTracker
//
//  Created by Minny Joseph on 17/12/24.
//

import Foundation

protocol DataPassingDelegate: AnyObject {
    func didReceiveData(_ data: String, _ item: [FilterData])
}

struct FilterData: Codable {
    var rowTitle: String
    var timeRange: String?
    var isSelected: Bool
}

class BottomSheetViewModel {
    var items: [FilterData] = []
    var filterVal: String = ""
}
