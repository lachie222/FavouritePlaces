//
//  FavouritePlacesApp.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 4/5/2022.
//

import SwiftUI

@main
struct FavouritePlacesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
