//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var place: Place
    @State var image = Image(systemName: "photo").resizable()
    /**
     Row view includes image thumbnail
     */
    var body: some View {
        HStack {
            image.aspectRatio(contentMode: .fit)
                .frame(width: 45, height: 30, alignment: .center)
            Text(place.placeName)
        }.task {
            image = await place.retrieveImage()
        }
    }
}

/*struct PlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRowView()
    }
}*/
