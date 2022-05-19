//
//  PlaceViewModel.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 5/5/2022.
//

import Foundation
import CoreData
import SwiftUI
import CoreLocation
import MapKit

fileprivate let defaultImage = Image(systemName: "photo")
fileprivate var downloadedImages = [URL: Image]()

extension Place {
    
    var placeName: String {
        get { name ?? ""}
        set {
            name = newValue
            save()
        }
    }
    
    var placeNotes: String {
        get { notes ?? "" }
        set {
            notes = newValue
            save()
        }
    }
    
    var placeUrlString: String {
        get { imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else {return}
            imageURL = url
            save()
        }
    }
    
    var placeLatitude: String {
        get { String(latitude) }
        set {
            guard let newLatitude = CLLocationDegrees(newValue) else {
                print ("Invalid Latitude")
                return
            }
            latitude = newLatitude
            save()
        }
    }
    
    var placeLongitude: String {
        get { String(longitude) }
        set {
            guard let newLongitude = CLLocationDegrees(newValue) else {
                print("Invalid Longitude")
                return
            }
            longitude = newLongitude
            save()
        }
    }
    
    var placeLocation: MKCoordinateRegion {
        return MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude,
                                           longitude: longitude),
            latitudinalMeters: 750,
            longitudinalMeters: 750
        )
    }
    
    func retrieveImage() async -> Image {
        guard let url = imageURL else { return defaultImage}
        if let image = downloadedImages[url] {return image}
        do {
            let (data, response) = try await URLSession.shared.data(from: url )
            print("Downloaded \(response.expectedContentLength) bytes")
            guard let uiImage = UIImage(data: data) else {return defaultImage}
            let image = Image(uiImage: uiImage).resizable()
            downloadedImages[url] = image
            return image
        } catch {
            print("Error downloading from url: \(url): \(error)")
        }
        return defaultImage
    }
    
    
    @discardableResult
    func save() -> Bool {
        do {
            try managedObjectContext?.save()
        } catch {
            print("Error when saving: \(error)")
            return false
        }
        return true
    }

}
