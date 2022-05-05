//
//  PlaceCRUD.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import Foundation
import SwiftUI
import CoreData

func addPlace(context: NSManagedObjectContext) {
    withAnimation {
        let newPlace = Place(context: context)
        newPlace.name = "New Place"

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

func deletePlaces(offsets: IndexSet, context: NSManagedObjectContext, places: FetchedResults<Place>) {
    withAnimation {
        offsets.map { places[$0] }.forEach(context.delete)

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}
