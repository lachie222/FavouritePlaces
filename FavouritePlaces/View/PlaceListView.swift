//
//  PlaceListView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI
import CoreData
struct PlaceListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Place.name, ascending: true)],
        animation: .default)
    var places: FetchedResults<Place>
    var body: some View {
        List {
            if places.count > 0 {
                ForEach(places) { place in
                    NavigationLink(destination: PlaceDetailView(place: place).navigationBarItems(trailing: EditButton())) {PlaceRowView(place: place)}
                }.onDelete { place in
                    deletePlaces(offsets: place, context: viewContext, places: places)
                }
            } else {
                Text("There are no places!").foregroundColor(.gray)
            }
        }
    }
    
    /*private func deletePlaces(offsets: IndexSet) {
        withAnimation {
            offsets.map { places[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}*/

/*struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
    }
}*/
}
