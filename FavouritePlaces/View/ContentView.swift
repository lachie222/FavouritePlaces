//
//  ContentView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 4/5/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    /**
     Fetches places from CoreData
     */
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    var places: FetchedResults<Place>
    
    var body: some View {
        NavigationView {
            PlaceListView()
                .navigationTitle("Favourite Places")
                .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                    addPlace(context: viewContext)
                }, label: {Image(systemName: "plus")}))
            }
        }
}





/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}*/
