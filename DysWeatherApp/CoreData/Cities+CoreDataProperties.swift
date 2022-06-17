//
//  Cities+CoreDataProperties.swift
//  DysWeatherApp
//
//  Created by dan4 on 10.06.2022.
//
//

import Foundation
import CoreData


extension Cities {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cities> {
        return NSFetchRequest<Cities>(entityName: "Cities")
    }

    @NSManaged public var name: String?
    @NSManaged public var temperature: Double
    @NSManaged public var visibility: Int16
    @NSManaged public var feelsLike: Double
    @NSManaged public var tempMax: Double
    @NSManaged public var tempMin: Double

}

extension Cities : Identifiable {

}
