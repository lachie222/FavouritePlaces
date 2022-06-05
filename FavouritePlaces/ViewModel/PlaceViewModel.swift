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
    /**
        Extends place CoreData model to include extra variables and methods
     */
    
    /**
     Getter and setter for sunrise/sunset times
     */
    var sunriseSunset: SunriseSunset {
        get { SunriseSunset(sunrise: sunrise ?? "Unknown", sunset: sunset ?? "Unknown")  }
        set {
            self.sunrise = newValue.sunrise
            self.sunset = newValue.sunset
            save()
        }
    }

    /**
     Getter and setter for name as String
     */
    var placeName: String {
        get { name ?? ""}
        set {
            name = newValue
            save()
        }
    }
    
    /**
     Getter and setter for notes as String
     */
    var placeNotes: String {
        get { notes ?? "" }
        set {
            notes = newValue
            save()
        }
    }
    
    
    /**
     Getter and setter for URL as string
     */
    var placeUrlString: String {
        get { imageURL?.absoluteString ?? "" }
        set {
            guard let url = URL(string: newValue) else {return}
            imageURL = url
            save()
        }
    }
    
    /**
     Getter and setter for latitude as String
     */
    var placeLatitude: String {
        get { String(latitude) }
        set {
            guard let newLatitude = Double(newValue) else {
                print ("Invalid Latitude")
                return
            }
            latitude = newLatitude
            save()
        }
    }
    
    /**
     Getter and setter for longitude as String
     */
    var placeLongitude: String {
        get { String(longitude) }
        set {
            guard let newLongitude = Double(newValue) else {
                print("Invalid Longitude")
                return
            }
            longitude = newLongitude
            save()
        }
    }
    
    /**
     Getter and setter for Location as CLLocation
     */
    var placeLocation: CLLocation {
        get {
            return CLLocation(latitude: latitude, longitude: longitude)
        }
        
        set(newLocation) {
            let newLatitude = newLocation.coordinate.latitude
            let newLongitude = newLocation.coordinate.longitude
            
            if CLLocationCoordinate2DIsValid(CLLocationCoordinate2D(latitude: newLatitude, longitude: newLongitude)) {
                latitude = newLatitude
                longitude = newLongitude
                save()
            } else {
                print("Location Invalid")
            }
        }
    }
    
    /**
     Function for geocoding coordinates based on place name
     */
    func lookupLocation(for placeName: String) {
        let coder = CLGeocoder()
        coder.geocodeAddressString(placeName) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error searching \(placeName): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks not found")
                return
            }
            let placemark = placemarks[0]
            guard let location = placemark.location else {
                print("Placemark does not contain a location")
                return
            }
            self.longitude = location.coordinate.longitude
            self.latitude = location.coordinate.latitude
        }
    }

    /**
     Function for geocoding placeName based on CLLocation coordinates
     */
    func lookupName(for location: CLLocation) {
        let coder = CLGeocoder()
        coder.reverseGeocodeLocation(location) { optionalPlacemarks, optionalError in
            if let error = optionalError {
                print("Error looking up \(location.coordinate): \(error.localizedDescription)")
                return
            }
            guard let placemarks = optionalPlacemarks, !placemarks.isEmpty else {
                print("Placemarks came back empty")
                return
            }
            let placemark = placemarks[0]
            self.placeName = placemark.subAdministrativeArea ?? placemark.locality ?? placemark.subLocality ?? placemark.name ?? placemark.thoroughfare ?? placemark.subThoroughfare ?? placemark.country ?? ""
        }
    }
    
    /**
     Function for looking up sunrise/sunset times using API
     */
    func lookupSunriseAndSunset() {
        guard let url = URL(string: "https://api.sunrise-sunset.org/json?lat=\(placeLatitude)&lng=\(placeLongitude)") else {
            print("Bad URL")
            return
        }
        guard let undecodedJsonData = try? Data(contentsOf: url) else {
            print("Could not find sunrise/sunset")
            return
        }
        guard let decodedJsonData = try? JSONDecoder().decode(SunriseSunsetAPI.self, from: undecodedJsonData) else {
            print("Could not decode JSON API:\n\(String(data: undecodedJsonData, encoding: .utf8) ?? "empty Data")")
            return
        }
        let inputFormat = DateFormatter()
        inputFormat.dateStyle = .none
        inputFormat.timeStyle = .medium
        inputFormat.timeZone = .init(secondsFromGMT: 0)
        let outputFormat = DateFormatter()
        outputFormat.dateStyle = .none
        outputFormat.timeStyle = .medium
        outputFormat.timeZone = .current
        var convertedTime = decodedJsonData.results
        if let time = inputFormat.date(from: decodedJsonData.results.sunrise) {
            convertedTime.sunrise = outputFormat.string(from: time)
        }
        if let time = inputFormat.date(from: decodedJsonData.results.sunset) {
            convertedTime.sunset = outputFormat.string(from: time)
        }
        sunriseSunset = convertedTime
    }
    
    /**
     Returns image based on url stored in object
     - Returns: Image
     */
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
    
    
    /**
     Saves current object state to CoreData
     */
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

