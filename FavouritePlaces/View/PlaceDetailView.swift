//
//  PlaceDetailView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI
import MapKit

struct PlaceDetailView: View {
    @Environment(\.editMode) var editMode
    @ObservedObject var place: Place
    @State var placeName = ""
    @State var placeNotes = ""
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
                    
                }
                
            } else {
                Text(place.placeName)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity, alignment: .center)
                image.aspectRatio(contentMode: .fit).task {
                    image = await place.retrieveImage()
                }
                

                
                List {
                    NavigationLink(destination: MapDetailView(place: place, region: place.placeLocation).navigationBarItems(trailing: EditButton()), label: {
                        HStack{
                            MapSnapshotView(region: place.placeLocation)
                                .frame(width: 150, height: 50, alignment: .center)
                            Spacer()
                            Text("Map of \(place.placeName)")
                        }
                    }
                    )
                    VStack (alignment: .leading) {
                        Text("Notes: ").fontWeight(.semibold)
                        Text(place.placeNotes)
                    }
                }
            }
        }
    }
}

/*struct PlaceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceDetailView()
    }
}*/
