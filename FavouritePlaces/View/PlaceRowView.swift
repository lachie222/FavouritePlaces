//
//  PlaceRowView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import SwiftUI

struct PlaceRowView: View {
    @ObservedObject var place: Place
    var body: some View {
        Text("\(place.placeName)")
    }
}

/*struct PlaceRowView_Previews: PreviewProvider {
    static var previews: some View {
        PlaceRowView()
    }
}*/
