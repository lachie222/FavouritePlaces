//
//  MapSnapshotView.swift
//  FavouritePlaces
//
//  Created by Lachlan Manson on 19/5/2022.
//

import SwiftUI
import MapKit

struct MapSnapshotView: View {
  let region: MKCoordinateRegion
  var span: CLLocationDegrees = 0.01

  @State private var snapshotImage: UIImage? = nil
    /**
     Generates a snapshot of map region
     - Returns: Snapshot Image
     */
    func generateSnapshot(width: CGFloat, height: CGFloat) {

      let mapOptions = MKMapSnapshotter.Options()
      mapOptions.region = region
      mapOptions.size = CGSize(width: width, height: height)

      let snapshotter = MKMapSnapshotter(options: mapOptions)
      snapshotter.start { (snapshotOrNil, errorOrNil) in
        if let error = errorOrNil {
          print(error)
          return
        }
        if let snapshot = snapshotOrNil {
          self.snapshotImage = snapshot.image
        }
      }
    }

    /**
     Display view for snapshot image
     */
    var body: some View {
      GeometryReader { geometry in
        Group {
            if let image = snapshotImage {
              Image(uiImage: image)
            } else {
              VStack {
                Spacer()
                HStack {
                  Spacer()
                  ProgressView().progressViewStyle(CircularProgressViewStyle())
                  Spacer()
                }
                Spacer()
              }
              .background(Color(UIColor.secondarySystemBackground))
            }
        }
        .onAppear {
          generateSnapshot(width: geometry.size.width, height: geometry.size.height)
        }
      }
    }
}


