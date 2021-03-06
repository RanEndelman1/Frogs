//
// Created by Ran Endelman on 10/09/2017.
// Copyright (c) 2017 RanEndelman. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation
import FirebaseDatabase

class MapViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var map: MKMapView!
    let manager = CLLocationManager()
    private var ref: DatabaseReference!
    var clickedRow: Int = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.setLatAndLong()
    }

    /* This method set the map to the specific lat and long */
    func setLatAndLong() {
        self.ref.child("highScores").observeSingleEvent(of: .value, with: { (snapshot) in
            var arr = snapshot.value as? [[String: Any]]
            var clickedDic: [String: Any] = arr![self.clickedRow]
            var lat: Double = clickedDic["lat"] as! Double
            var long: Double = clickedDic["long"] as! Double
            let span:MKCoordinateSpan = MKCoordinateSpanMake(0.01, 0.01)
            let recordLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
            let region:MKCoordinateRegion = MKCoordinateRegionMake(recordLocation, span)
            self.map.setRegion(region, animated: true)
            self.map.showsUserLocation = true
            let annotation = MKPointAnnotation()
            annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            self.map.addAnnotation(annotation)
            self.map.showsCompass = true
            self.map.center = self.view.center
            self.view.addSubview(self.map)
        }) { (error) in
            print(error.localizedDescription)
        }
    }


}
