//
//  PlaceDetailView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI

struct PlaceDetailView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @State var placeName = ""
    @State var placeNotes = ""
    @State var placeLatitude = ""
    @State var placeLongitude = ""
    @State var placeImageURL = ""
    @State var longitudeValidity = false
    @State var latitudeValidity = false
    @State var image = Image(systemName: "photo")
    
    
    var body: some View {
        VStack (alignment: .center, spacing: 5) {
            if editMode?.wrappedValue == .active {
                Text("Edit Place Name: ")
                TextField(place.placeName, text:$placeName) {
                        place.placeName = placeName
                        placeName = ""
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
            .padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
                List {
                    Text("Edit Image URL: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField(place.placeUrlString, text:$placeImageURL) {
                            place.placeUrlString = placeImageURL
                            placeImageURL = ""
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                .padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    Text("Edit Place Notes: ").frame(maxWidth: .infinity, alignment: .center)
                    TextField(place.placeNotes, text:$placeNotes) {
                            place.placeNotes = placeNotes
                            placeNotes = ""
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                .padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    Text("Edit Place Latitude: ").frame(maxWidth: .infinity, alignment: .center)
                    if latitudeValidity == true {
                        Text("Please Enter a Valid Number").foregroundColor(.red)
                    }
                    TextField(String(place.latitude), text:$placeLatitude) {
                        if Double(placeLatitude) != nil {
                            place.latitude = Double(placeLatitude) ?? 0.0
                            latitudeValidity = false
                        } else {
                            placeLatitude = ""
                            latitudeValidity = true
                        }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                .padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    Text("Edit Place Longitude: ").frame(maxWidth: .infinity, alignment: .center)
                    if longitudeValidity == true {
                        Text("Please Enter a Valid Number").foregroundColor(.red)
                    }
                    TextField(String(place.longitude), text:$placeLongitude) {
                        if Double(placeLongitude) != nil {
                            place.longitude = Double(placeLongitude) ?? 0.0
                            longitudeValidity = false
                        } else {
                            placeLongitude = ""
                            longitudeValidity = true
                        }
                        }
                        .padding(.horizontal, 10)
                        .padding(.vertical, 4)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.black, lineWidth: 1))
                .padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                }
            } else {
                Text(place.placeName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                image.aspectRatio(contentMode: .fit)
                List {
                    Text("Place Notes: \(place.placeNotes)")
                    Text("Place Latitude: \(place.latitude)")
                    Text("Place Longitude: \(place.longitude)")
                }
            }
        }.task {
            image = await place.retrieveImage()
        }
    }
}

/*struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView()
    }
}*/
