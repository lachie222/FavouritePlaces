//
//  MapDetailView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 19/5/2022.
//

import SwiftUI
import CoreLocation
import MapKit

struct MapDetailView: View {
    @ObservedObject var place: Place
    @State var placeLocation: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $placeLocation).onChange(of: placeLocation.center.latitude, perform: {newValue in
            place.latitude = newValue
        }).onChange(of: placeLocation.center.longitude, perform: {newValue in
            place.longitude = newValue
        })
    }
}

/*struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView()
    }
}*/
