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
    @State var placeLocation: MKCoordinateRegion
    
    var body: some View {
        Map(coordinateRegion: $placeLocation)
    }
}

/*struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView()
    }
}*/
