//
//  ViewController.swift
//  map app
//
//  Created by period4 on 5/25/21.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, UISearchBarDelegate, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var map: MKMapView!
    
    let mapView = MKMapView()
    
    let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 42.0664, longitude: -87.9373), latitudinalMeters: 10000, longitudinalMeters: 10000)
        let school = Place(title: "Prospect Highschool", coordinate: CLLocationCoordinate2D(latitude: 42.0791, longitude: -87.9497), info: "This is my HighSchool")
    let park = Place(title: "Where I hoop", coordinate: CLLocationCoordinate2D(latitude: 42.0777445, longitude: -87.9607407), info: "This is where I ball up")
    
    let bestPlaceToEat = Place(title: "TACO BELL", coordinate: CLLocationCoordinate2D(latitude: 42.0947178, longitude: -87.9531751), info: "This is where I eat")


    let locationManager = CLLocationManager()
    
    var mpCoord = CLLocationCoordinate2D(latitude: 42.0664, longitude: -87.9373)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkLocationServices()
        setupLocationManager()
                
        //map.mapType = .satelliteFlyover
        map.showsCompass = true
        map.showsTraffic = true
        map.showsCompass = true
        map.showsUserLocation = true
        //map.centerCoordinate = mpCoord
        map.addAnnotation(school)
        map.addAnnotation(park)
        map.addAnnotation(bestPlaceToEat)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let location = locations.last else { return }
           let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: 4000, longitudinalMeters: 4000)
           map.setRegion(region, animated: true)
       }
      
       func checkLocationAuthorization() {
           switch CLLocationManager.authorizationStatus() {
           case .authorizedWhenInUse:
               map.showsUserLocation = true
               followUserLocation()
               locationManager.startUpdatingLocation()
               break
           case .denied:
               // Show alert
               break
           case .notDetermined:
               locationManager.requestWhenInUseAuthorization()
           case .restricted:
               // Show alert
               break
           case .authorizedAlways:
               break
           default: break
            // fatalError()
           }
       }
       
       func checkLocationServices() {
           if CLLocationManager.locationServicesEnabled() {
               setupLocationManager()
               checkLocationAuthorization()
           } else {
               // the user didn't turn it on
           }
       }
       
       func followUserLocation() {
           if let location = locationManager.location?.coordinate {
               let region = MKCoordinateRegion.init(center: location, latitudinalMeters: 4000, longitudinalMeters: 4000)
               map.setRegion(region, animated: true)
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
           checkLocationAuthorization()
       }
       
       func setupLocationManager() {
           locationManager.delegate = self
           locationManager.desiredAccuracy = kCLLocationAccuracyBest
       }
    
    
    

}

