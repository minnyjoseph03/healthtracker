//
//  WaterInTake+CoreDataProperties.swift
//  HealthTracker
//
//  Created by Minny Joseph on 16/12/24.
//
//

import Foundation
import CoreData


extension WaterInTake {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WaterInTake> {
        return NSFetchRequest<WaterInTake>(entityName: "WaterInTake")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var timeStamp: Date?
    @NSManaged public var timeType: String?
    @NSManaged public var value: Double

}

extension WaterInTake : Identifiable {

}
