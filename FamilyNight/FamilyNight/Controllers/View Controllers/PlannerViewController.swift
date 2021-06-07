//
//  PlannerViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/25/21.
//
import Firebase
import UIKit
import CoreLocation
import MapKit

class PlannerViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var parkButton: UIButton!
    @IBOutlet weak var hikesButton: UIButton!
    @IBOutlet weak var movieTheatreButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
        setupViews()
        checkLocationAuthorization()
        centerViewOnUserLocation()
        setupLocationManager()
        checkLocationServices()
        popKeyboard()
    }
    
    //MARK: - Actions
    
    @IBAction func parkButtonTapped(_ sender: Any) {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else {return}
        let areaLat = locValue.latitude
        let areaLon = locValue.longitude
        let area = "\(areaLat)\(areaLon)"
        let parkURL = "http://maps.apple.com/?q=parks&s"
        let finalURL = "\(parkURL)\(area)"
        
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            UIApplication.shared.open(URL(string:
            "\(finalURL)")!)
            print(finalURL)
            
        } else {
          NSLog("Can't use Apple Maps");
        }
    }
    
    @IBAction func movieTheatreButtonTapped(_ sender: Any) {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else {return}
        let areaLat = locValue.latitude
        let areaLon = locValue.longitude
        let area = "\(areaLat)\(areaLon)"
        
        let parkURL = "http://maps.apple.com/?q=movie+theatre&s"
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            UIApplication.shared.open(URL(string:
            "\(parkURL)\(area)")!)
        } else {
          NSLog("Can't use Apple Maps");
        }
    }
    
    @IBAction func hikesButtonTapped(_ sender: Any) {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else {return}
        let areaLat = locValue.latitude
        let areaLon = locValue.longitude
        let area = "\(areaLat)\(areaLon)"
        
        let parkURL = "http://maps.apple.com/?q=trailheads&s"
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            UIApplication.shared.open(URL(string:
            "\(parkURL)\(area)")!)
        } else {
          NSLog("Can't use Apple Maps");
        }
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text,
              let startDate = startDatePicker?.date,
              let location = locationTextField.text
            
        else {return}
        if let event = event {
            event.title = title
            event.description = description
            event.startDate = startDate
            event.location = location
            
            EventController.shared.updateEvent(event: event)
        } else {
            let newEvent = Event(title: title, description: description, startDate: startDate, location: location)
            EventController.shared.createEvent(for: newEvent)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        
    }

    
    //MARK: - Properties
    var event: Event?
    let regionInMeters: Double = 1000
    let locationManager = CLLocationManager()
    
    //MARK: - Functions
    
    func popKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))

            self.view.addGestureRecognizer(tap)
        }

        @objc func hideKeyboardByTappingOutside() {
            self.view.endEditing(true)
        
    }
    
   // ADRESS TO COORDINATES
    func getLocation(from address: String, completion: @escaping (_ location: CLLocationCoordinate2D?)-> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            guard let placemarks = placemarks,
            let location = placemarks.first?.location?.coordinate else {
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
//    var geocoder = CLGeocoder()
//    func geocoder.geocodeAddressString("location") {
//        placemarks, error in
//        let placemark = placemarks?.first
//        let lat = placemark?.location?.coordinate.latitude
//        let lon = placemark?.location?.coordinate.longitude
//        print("Lat: \(lat), Lon: \(lon)")
//    }
//
    
    
    //Setup Views
    func setupViews() {
        titleTextField.text = event?.title
        descriptionTextView.text = event?.description
        startDatePicker.date = event?.startDate ?? Date()
        locationTextField.text = event?.location
    }
    
    //MARK: - Location Functions
    func checkLocationAuthorization() {
        switch  CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
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
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
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
    
    
    //MARK: - Styles
    func addStyle() {
        //View
        view.backgroundColor = CustomColors.Tan
        //Title Text Field
        self.titleTextField.backgroundColor = CustomColors.Tan
        self.titleTextField.textColor = CustomColors.DarkBlue
        self.titleTextField.borderStyle = .roundedRect
        //Create Button
        self.createButton.backgroundColor = CustomColors.Green
        self.createButton.addCornerRadius()
        //SAVE BUTTON
        //Detail Text View
        self.descriptionTextView.backgroundColor = CustomColors.lightgrayblue
        self.descriptionTextView.tintColor = CustomColors.GrayBlue
        self.descriptionTextView.textColor = CustomColors.GrayBlue
//        self.descriptionTextView.text = "Insert details here...(who, what, when, where)"
        self.descriptionTextView.addRoundedCorner()
        //Quick Places Button Styles
        parkButton.backgroundColor = CustomColors.ParkGreen
        parkButton.tintColor = .white
        parkButton.addCornerRadius()
        movieTheatreButton.backgroundColor = CustomColors.GrayBlue
        movieTheatreButton.tintColor = .white
        movieTheatreButton.addCornerRadius()
        hikesButton.backgroundColor = CustomColors.ForestGreen
        hikesButton.tintColor = .white
        hikesButton.addCornerRadius()
    }
    
    
    
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}//End of class

//MARK: - Extensions
extension PlannerViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error:: (error)")
    }
}//End of extension

