//
//  PlaceListView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI
import CoreData
import MapKit

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
    

/*struct PlaceListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceListView()
    }
}*/
}
