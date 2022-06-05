//
//  FavouritePlacesTests.swift
//  FavouritePlacesTests
//
//  Created by Lachlan Manson on 4/5/2022.
//

import XCTest
@testable import FavouritePlaces

class FavouritePlacesTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testPlace() throws {
        let context = PersistenceController.init().container.viewContext
        let newPlace = Place(context: context)
        newPlace.name = "Brisbane"
        XCTAssertEqual(newPlace.name, "Brisbane")
    }
    
    func testSunriseSunsetModel() throws {
        let context = PersistenceController.init().container.viewContext
        let newPlace = Place(context: context)
        newPlace.name = "Brisbane"
        newPlace.lookupLocation(for: newPlace.placeName)
        newPlace.lookupSunriseAndSunset()
        XCTAssertNotEqual(newPlace.sunrise, "Unknown")
        XCTAssertNotEqual(newPlace.sunrise, nil)
        
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
