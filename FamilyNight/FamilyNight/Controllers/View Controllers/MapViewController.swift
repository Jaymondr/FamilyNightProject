//
//  MapViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/1/21.
//

import UIKit
import MapKit
import CoreLocation

protocol HandleMapSearch: AnyObject {
    func dropPinZoomIn(placemark:MKPlacemark)
}
class MapViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var mapView: MKMapView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = CustomColors.GrayBlue
        addStyle()
        checkLocationAuthorization()
        centerViewOnUserLocation()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkLocationServices()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        
    }
    
    //MARK: - Actions
    //MARK: - Properties
    let regionInMeters: Double = 1000
    var resultSearchController: UISearchController? = nil
    var selectedPin: MKPlacemark? = nil
    let locationManager = CLLocationManager()

    
    //MARK: - Functions
    func addStyle() {
    }
    
    @objc func mapLongPress(_ recognizer: UIGestureRecognizer) {
//        print("A long press has been detected.")
//
//        let touchedAt = recognizer.location(in: self.mapView) // adds the location on the view that was pressed
//        let touchedAtCoordinate : CLLocationCoordinate2D = mapView.convert(touchedAt, toCoordinateFrom: self.mapView) // will get coordinates
//        let newPin: MKPointAnnotation = MKPointAnnotation()

    }
    
    func checkLocationAuthorization() {
        switch  CLLocationManager().authorizationStatus {
        case .authorizedWhenInUse:
//            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            // show alert telling them how to turn it on
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            break
        case .authorizedAlways:
            break
        }
    }
    
    func centerViewOnUserLocation() {
//        if let location = locationManager.location?.coordinate {
//            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//            mapView.setRegion(region, animated: true)
//        }
    }
    
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
            //setup location manager
        } else {
            //show aler telling user how to turn this on
        }
    }
    
    func addSearchBar() {
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.searchController = resultSearchController
        searchBar.delegate = self
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
}//End of class

//MARK: - Extensions
extension MapViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else {return}
//        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
    }
}

private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print("error:: (error)")
}//End of extension
extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("Test")
    }
}//End of extension
extension MapViewController: HandleMapSearch {
    
    func dropPinZoomIn(placemark: MKPlacemark){
        // cache the pin
//        selectedPin = placemark
//        // clear existing pins
//        mapView.removeAnnotations(mapView.annotations)
//        let annotation = MKPointAnnotation()
//        annotation.coordinate = placemark.coordinate
//        annotation.title = placemark.name
//
//        if let city = placemark.locality,
//            let state = placemark.administrativeArea {
//                annotation.subtitle = "\(city) \(state)"
//        }
//
//        mapView.addAnnotation(annotation)
//        let span = MKCoordinateSpan(latitudeDelta: regionInMeters, longitudeDelta: regionInMeters)
//        let region = MKCoordinateRegion.init(center: placemark.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
    }
}//End of extension
