//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 19/5/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable
/**
    Makes MKCoordinateRegion equatable
 */
{
   public static func == (lhs: MKCoordinateRegion, rhs: MKCoordinateRegion) -> Bool
   {
       if lhs.center.latitude != rhs.center.latitude || lhs.center.longitude != rhs.center.longitude
       {
           return false
       }
       if lhs.span.latitudeDelta != rhs.span.latitudeDelta || lhs.span.longitudeDelta != rhs.span.longitudeDelta
       {
           return false
       }
       return true
   }
}
