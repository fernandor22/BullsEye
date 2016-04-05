//
//  ViewController.swift
//  LocationApp
//
//  Created by Fernando Rios on 04/04/16.
//  Copyright © 2016 Fernando Rios. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var lat: UILabel!
    @IBOutlet weak var lng: UILabel!
    @IBOutlet weak var acc: UILabel!
    @IBOutlet weak var speed: UILabel!
    @IBOutlet weak var alt: UILabel!
    @IBOutlet weak var address: UILabel!
    
    var locationManager: CLLocationManager!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations[0]
        
        self.lat.text = "Latitude: \(location.coordinate.latitude)"
        self.lng.text = "Longitude: \(location.coordinate.longitude)"
        self.acc.text = "Accuracy: \(location.verticalAccuracy)"
        self.speed.text = "Speed: \(location.speed)"
        self.alt.text = "Altitude: \(location.altitude)"
        
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if (error != nil) {
                print(error)
            }
            else {
                if let p = placemarks?[0] {
                    var addText = ""
                    
                    if let thoroughfare = p.thoroughfare {
                        addText.appendContentsOf(thoroughfare)
                    }
                    
                    if let subLocality = p.subLocality {
                        addText.appendContentsOf("\n " + subLocality)
                    }
                    
                    if let administrativeArea = p.administrativeArea {
                        addText.appendContentsOf("\n " + administrativeArea)
                    }
                    if let postalCode = p.postalCode {
                        addText.appendContentsOf("\n \(postalCode)")
                    }
                    if let country = p.country {
                        addText.appendContentsOf("\n" + country)
                    }
                    
                    self.address.text = addText
                }
            }
        } )
    

    }
}
