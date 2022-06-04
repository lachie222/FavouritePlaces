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
            HStack {
                Button(action: {place.lookupLocation(for: place.placeName)}, label: {Image(systemName: "text.magnifyingglass")})
                Text("Search Place: ")
                TextField("Search Place", text: $place.placeName) {
                    place.lookupLocation(for: place.placeName)
                }
            }
            Map(coordinateRegion: $region).onChange(of: region, perform: {newValue in
                place.placeLocation = newValue
            })
        }
        
        if editMode?.wrappedValue == .active {
            
            List {
                VStack {
                    Text("Edit Latitude: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField("Edit Latitude", text: $region.latitudeString)
                    .textFieldStyle(PrimaryTextFieldStyle())
            }.padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
                
                VStack {
                    Text("Edit Longitude: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField("Edit Longitude", text: $region.longitudeString)
                    .textFieldStyle(PrimaryTextFieldStyle())
            }.padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
            }
        }
        else {
            Text("Latitude: \(place.placeLatitude)")
            Text("Longitude: \(place.placeLongitude)")
            Button("Search Location"){
                place.lookupName(for: CLLocation(latitude: place.latitude, longitude: place.longitude))
            }
        }

    }
}

/*struct MapDetailView_Previews: PreviewProvider {
    static var previews: some View {
        MapDetailView()
    }
}*/
