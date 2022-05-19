//
//  CoordinateRegionViewModel.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 19/5/2022.
//

import Foundation
import MapKit

extension MKCoordinateRegion: Equatable
{
    var latitudeString: String {
        get { "\(center.latitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: degrees, longitude: center.longitude)) {
                center.latitude = degrees
            } else { return }
        }
    }
    var longitudeString: String {
        get { "\(center.longitude)" }
        set {
            guard let degrees = CLLocationDegrees(newValue) else { return }
            if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: center.latitude, longitude: degrees)) {
                center.longitude = degrees
            } else { return }
        }
    }
    
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
