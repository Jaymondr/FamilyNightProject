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
import EventKit

class PlannerViewController: UIViewController, UITextViewDelegate {
    
    //MARK: - Outlets
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var parkButton: UIButton!
    @IBOutlet weak var hikesButton: UIButton!
    @IBOutlet weak var movieTheatreButton: UIButton!
    @IBOutlet weak var locationTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
        setupViews()
        checkLocationAuthorization()
        setupLocationManager()
        checkLocationServices()
        hideKeyboard()
    }
    
    //MARK: - Actions
    @IBAction func locationButtonTapped(_ sender: Any) {
        
        let alertController = UIAlertController(title: "Add Location", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (textfield : UITextField!) -> Void in
            textfield.placeholder = "Enter Address"
        }
        
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            
            self.locationTextField.text = alertController.textFields![0].text
        })
        
        alertController.addAction(saveAction)
        present(alertController, animated: true)
    }
    
    @IBAction func parkButtonTapped(_ sender: Any) {
        guard let locValue: CLLocationCoordinate2D = locationManager.location?.coordinate else {return}
        let areaLat = locValue.latitude
        let areaLon = locValue.longitude
        let area = "\(areaLat)\(areaLon)"
        let parkURL = "http://maps.apple.com/?q=parks&s"
        let finalURL = "\(parkURL)\(area)"
        
        if (UIApplication.shared.canOpenURL(URL(string:"http://maps.apple.com")!)) {
            UIApplication.shared.open(URL(string: "\(finalURL)")!)
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
        saveEvent()
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func createButtonTapped(_ sender: Any) {
        saveEvent()
        guard let event = self.event else {return}
        
        let alert = UIAlertController(title: "Create Event", message: "Would you like to add this event to your calendar, or create a link", preferredStyle: .alert)
        let calendarAction = UIAlertAction(title: "Calendar", style: .default) { result in
            let successAlert = UIAlertController(title: "Event has been added to your calendar", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .cancel) { _ in
                self.navigationController?.popViewController(animated: true)
            }
            successAlert.addAction(okAction)
            self.present(successAlert, animated: true, completion: nil)
            

            self.eventStore.requestAccess(to: .event) { (granted, error) in
                
                if (granted) && (error == nil) {
                    print("granted \(granted)")
                    print("error \(String(describing: error))")
                    
                    let event:EKEvent = EKEvent(eventStore: self.eventStore)
                    
                    event.title = self.event?.title
                    event.startDate = self.event?.startDate
                    event.endDate = self.event?.endDate
                    event.notes = self.event?.description
                    event.location = self.event?.location
                    event.calendar = self.eventStore.defaultCalendarForNewEvents
                    
                    do {
                        try self.eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("failed to save event with error : \(error)")
                    }
                    
                    print("Saved Event")
                }
                else{
                    
                    print("failed to save event with error : \(String(describing: error)) or access not granted")
                }
            }
        }
        let linkAction = UIAlertAction(title: "Link", style: .default) { _ in
            var components = URLComponents()
            components.scheme = self.scheme
            components.host = self.host
            components.path = self.path
            
            let eventIDQueryItem = URLQueryItem(name: "id", value: event.id)
            components.queryItems = [eventIDQueryItem]
            
            guard let linkParameter = components.url else {return}
            print("I am sharing \(linkParameter.absoluteString)")
            //Create the big dynamic link
            guard let shareLink = DynamicLinkComponents.init(link: linkParameter, domainURIPrefix: self.appLink)
            else {
                print("couldnt create FDL components")
                return
            }
            if let myBundleId = Bundle.main.bundleIdentifier {
                shareLink.iOSParameters = DynamicLinkIOSParameters(bundleID: myBundleId)
                
            }
            shareLink.iOSParameters?.appStoreID = "962194608"
            shareLink.socialMetaTagParameters = DynamicLinkSocialMetaTagParameters()
            shareLink.socialMetaTagParameters?.title = "\(event.title) from Family Night"
            shareLink.socialMetaTagParameters?.descriptionText = event.description
            //        shareLink.socialMetaTagParameters?.imageURL =
            guard let longURL = shareLink.url else {return}
            print(longURL.absoluteString)
            
            self.showShareSheetURL(url: longURL)
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            
        }
        
        alert.addAction(calendarAction)
        alert.addAction(linkAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true)
        
    }
    
    func showShareSheetURL(url: URL) {
        let promoText = "You've been invited to this cool event! \(self.event?.title ?? "") View in Family Night App!"
        let activityVC = UIActivityViewController(activityItems: [promoText, url], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    
    
    
    
    //MARK: - Properties
    var event: Event?
    let scheme = "https"
    let host = "www.familynight.com"
    let path = "/events"
    let appLink = "https://familynight.page.link/test1"
    let eventStore : EKEventStore = EKEventStore()
    
    let regionInMeters: Double = 1000
    let locationManager = CLLocationManager()
    var placeholder = Idea(title: "\(placeHolderIdea)")
    
    //MARK: - Functions
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboardByTappingOutside))
        
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func hideKeyboardByTappingOutside() {
        self.view.endEditing(true)
        
    }
    
    //Setup Views
    func setupViews() {
        descriptionTextView.delegate = self
        titleTextField.text = event?.title
        descriptionTextView.text = event?.description
        startDatePicker.date = event?.startDate ?? Date()
        endDatePicker.date = event?.endDate ?? Date()
        locationTextField.text = event?.location
    }
    
    func saveEvent() {
        guard let title = titleTextField.text, !title.isEmpty,
              let description = descriptionTextView.text,
              let startDate = startDatePicker?.date,
              let endDate = endDatePicker?.date,
              let location = locationTextField.text
        
        else {return}
        if let event = event {
            event.title = title
            event.description = description
            event.startDate = startDate
            event.endDate = endDate
            event.location = location
            
            EventController.shared.updateEventInFirebase(event: event)
            EventController.shared.updateEvent(event: event, title: title, description: description, startDate: startDate, endDate: endDate, location: location)
        } else {
            let newEvent = Event(title: title, description: description, startDate: startDate, endDate: endDate, location: location)
            EventController.shared.createEventInFirebase(event: newEvent)
            EventController.shared.createEvent(event: newEvent)
            
        }
        
    }
    
    //MARK: - Location Functions
    func checkLocationAuthorization() {
        switch  CLLocationManager().authorizationStatus {
        case .authorizedWhenInUse:
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
        assignbackground()
        //        view.backgroundColor = CustomColors.Tan
        //Title Text Field
        self.titleTextField.backgroundColor = UIColor.clear
        self.titleTextField.textColor = UIColor.white
        self.titleTextField.borderStyle = .roundedRect
        //Create Button
        self.createButton.backgroundColor = CustomColors.Green
        self.createButton.addCornerRadius()
        //SAVE BUTTON
        //Detail Text View
        self.descriptionTextView.backgroundColor = CustomColors.lightgrayblue
        self.descriptionTextView.tintColor = CustomColors.GrayBlue
        self.descriptionTextView.textColor = CustomColors.GrayBlue
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
    func assignbackground(){
        let background = UIImage(named: "launchScreenImageInv")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = placeholder.title
            textView.textColor = UIColor.lightGray
            placeholder.title = placeholder.title
        } else {
            placeholder.title = textView.text
        }
    }
    
}//End of class


//MARK: - Extensions
extension PlannerViewController : CLLocationManagerDelegate {
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    }
    
    
    private func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error: (error)")
    }
}//End of extension


