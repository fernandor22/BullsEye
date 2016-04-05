//
//  MapViewController.swift
//  LocationApp
//
//  Created by Fernando Rios on 04/04/16.
//  Copyright © 2016 Fernando Rios. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var locationManager = CLLocationManager()

    @IBOutlet weak var map: MKMapView!
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let hikerLocation: CLLocation = locations[0]
        let lat = hikerLocation.coordinate.latitude
        let lng = hikerLocation.coordinate.longitude
        let latDelta: CLLocationDegrees = 0.1
        let lngDelta: CLLocationDegrees = 0.1
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lngDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, lng)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        self.map.setRegion(region, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
