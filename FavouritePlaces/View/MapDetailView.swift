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
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @State var region: MKCoordinateRegion

    var body: some View {
        VStack{
            Text(place.placeName)
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .center)
            if editMode?.wrappedValue == .active {
                HStack {
                    Button(action: {place.lookupLocation(for: place.placeName)}, label: {Image(systemName: "text.magnifyingglass")})
                    Text("Search Place: ")
                    TextField("Search Place", text: $place.placeName) {
                        place.lookupLocation(for: place.placeName)
                    }
                }
            }
            Map(coordinateRegion: $region).onChange(of: region, perform: {newValue in
                place.longitude = newValue.center.longitude
                place.latitude = newValue.center.latitude
                place.longitudeMeters = newValue.span.longitudeDelta
                place.latitudeMeters = newValue.span.latitudeDelta
            }).onChange(of: place.placeLocation, perform: {newValue in
                region.center.longitude = place.longitude
                region.center.latitude = place.latitude
            })
        }
        
        if editMode?.wrappedValue == .active {
            
            VStack{
                VStack {
                    Text("Edit Latitude: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField("Edit Latitude", text: $place.placeLatitude)
                    .textFieldStyle(PrimaryTextFieldStyle())
            }.padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
                
                VStack {
                    Text("Edit Longitude: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField("Edit Longitude", text: $place.placeLongitude)
                    .textFieldStyle(PrimaryTextFieldStyle())
            }.padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
            }
            Button("Search by Coordinates"){
                place.lookupName(for: place.placeLocation)
            }
            }
        else {
            Text("Latitude: \(place.placeLatitude)")
            Text("Longitude: \(place.placeLongitude)")
        }

    }
}

/*struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView()
    }
}*/
