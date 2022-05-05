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
                VStack {
                    Text("Edit Place Name: ")
                    TextField(place.placeName, text:$placeName) {
                            place.placeName = placeName
                            placeName = ""
                    }.onTapGesture {
                        placeName = place.placeName
                    }
                    .textFieldStyle(PrimaryTextFieldStyle())
            }.padding([.leading, .trailing], 15)
            .multilineTextAlignment(.center)
                
                List {
                    VStack {
                        Text("Edit Image URL: ").frame(maxWidth: .infinity, alignment: .center)
                        TextField(place.placeUrlString, text:$placeImageURL) {
                                place.placeUrlString = placeImageURL
                                placeImageURL = ""
                        }.onTapGesture {
                            placeImageURL = place.placeUrlString
                        }
                        .textFieldStyle(PrimaryTextFieldStyle())
                }.padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    
                    VStack {
                        Text("Edit Place Notes: ").frame(maxWidth: .infinity, alignment: .center)
                        TextField(place.placeNotes, text:$placeNotes) {
                                place.placeNotes = placeNotes
                                placeNotes = ""
                        }.onTapGesture {
                            placeNotes = place.placeNotes
                        }
                        .textFieldStyle(PrimaryTextFieldStyle())
                }.padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    
                    VStack {
                        Text("Edit Place Latitude: ").frame(maxWidth: .infinity, alignment: .center)
                        TextField(place.placeLatitude, text:$placeLatitude) {
                            if Double(placeLatitude) != nil {
                                place.placeLatitude = placeLatitude
                                latitudeValidity = false
                                placeLatitude = ""
                            } else {
                                placeLatitude = ""
                                latitudeValidity = true
                            }
                        }.onTapGesture {
                            placeLatitude = place.placeLatitude
                        }
                        .textFieldStyle(PrimaryTextFieldStyle())
                }.padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    if latitudeValidity == true {
                        Text("Please Enter a Valid Number")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    VStack {
                        Text("Edit Place Longitude: ").frame(maxWidth: .infinity, alignment: .center)
                        TextField(place.placeLongitude, text:$placeLongitude) {
                            if Double(placeLongitude) != nil {
                                place.placeLongitude = placeLongitude
                                longitudeValidity = false
                                placeLongitude = ""
                            } else {
                                placeLongitude = ""
                                longitudeValidity = true
                            }
                        }.onTapGesture {
                            placeLongitude = place.placeLongitude
                        }
                        .textFieldStyle(PrimaryTextFieldStyle())
                }.padding([.leading, .trailing], 15)
                .multilineTextAlignment(.center)
                    if longitudeValidity == true {
                        Text("Please Enter a Valid Number")
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
            } else {
                Text(place.placeName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                image.aspectRatio(contentMode: .fit)
                
                List {
                    VStack (alignment: .leading) {
                        Text("Notes: ").fontWeight(.semibold)
                        Text(place.placeNotes)
                    }
                    HStack {
                        Text("Latitude: ").fontWeight(.semibold)
                        Text(place.placeLatitude)
                    }
                    HStack {
                        Text("Longitude: ").fontWeight(.semibold)
                        Text(place.placeLongitude)
                    }
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
