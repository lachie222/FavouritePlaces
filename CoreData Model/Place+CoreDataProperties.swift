//
//  Place+CoreDataProperties.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//
//

import Foundation
import CoreData


extension Place {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Place> {
        return NSFetchRequest<Place>(entityName: "Place")
    }

    @NSManaged public var imageURL: URL?
    @NSManaged public var latitude: Int16
    @NSManaged public var longitude: Int16
    @NSManaged public var name: String?
    @NSManaged public var notes: String?

}

extension Place : Identifiable {

}
