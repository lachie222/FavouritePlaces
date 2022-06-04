//
//  Place+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 4/6/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var imageURL: URL?
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var name: String?
    @NSManaged public var notes: String?
    @NSManaged public var latitudeMeters: Double
    @NSManaged public var longitudeMeters: Double

}

extension Place : Identifiable {

}
