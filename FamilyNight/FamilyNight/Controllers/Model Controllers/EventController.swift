//
//  EventModelController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/2/21.
//

import UIKit
import FirebaseFirestore
import MapKit
import FirebaseAuth

class EventController {
    //MARK: - Shared Instance
    static let shared = EventController()
    
    //MARK: - SOURCE OF TRUTH
    var events: [Event] = []
    var eventDynamicLink: Event?
    //MARK: - REFERENCE TO DATABASE
    let db = Firestore.firestore()
    
    
    //MARK: - CRUD FUNCTIONS
    func createEvent(for event: Event) {
        let eventToAdd: Event = event
        
        let eventRef = db.collection("events").document(eventToAdd.id)
        eventRef.setData(["title" : eventToAdd.title,
                          "description" : eventToAdd.description,
                          "startDate" : eventToAdd.startDate,
                          "location" : eventToAdd.location,
                          "id" : eventToAdd.id
        ])
        events.append(eventToAdd)
    }
    
    func updateEvent(event: Event) {
        let eventRef = db.collection("events").document(event.id) //create a reference to an event and assign it to eventRef
        eventRef.setData(["title" : event.title,
                          "description" : event.description,
                          "startDate" : event.startDate,
                          "location" : event.location], merge: true)
    }
    
    func delete(event: Event) {
        db.collection("events").document(event.id).delete()
        { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
            guard let index = self.events.firstIndex(of: event) else {return}
            self.events.remove(at: index)
        }
    }
    
    func fetchEvents(completion: @escaping (Bool) -> Void) {
        db.collection("events").addSnapshotListener { snapshot, error in
            self.events = [] //setting to an empty array to prevent duplicates
            
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                return completion(false)
            }
            if let snapshot = snapshot {
                for doc in snapshot.documents {
                    
                    let eventData = doc.data()
                    let title = eventData["title"] as? String ?? ""
                    let description = eventData["description"] as? String ?? ""
                    let startDate: Date = Timestamp.dateValue(eventData["startDate"] as? Timestamp ?? Timestamp())()
                    //                    let startDate = eventData["startDate"] as? Date ?? Date()
                    
                    let location = eventData["location"] as? String ?? ""
                    let id = eventData["id"] as? String ?? ""
                    
                    let event = Event(title: title, description: description, startDate: startDate, location: location, id: id)
                    self.events.append(event)
                }
                completion(true)
            }
        }
    }
    
    func fetchEventWith(id: String, completion: @escaping (Bool) -> Void) {
        db.collection("events").whereField("id", isEqualTo: id)
            .getDocuments() { (querySnapshot, error) in
                if let error = error {
                    print("error getting docs: \(error)")
                    return completion(false)
                }
                if let snapshot = querySnapshot {
                    for doc in snapshot.documents {
                        let eventData = doc.data()
                        let title = eventData["title"] as? String ?? ""
                        let description = eventData["description"] as? String ?? ""
                        let startDate: Date = Timestamp.dateValue(eventData["startDate"] as? Timestamp ?? Timestamp())()
                        let location = eventData["location"] as? String ?? ""
                        let id = eventData["id"] as? String ?? ""
                        
                        let event = Event(title: title, description: description, startDate: startDate, location: location, id: id)
                        self.eventDynamicLink = event
                    }
                    completion(true)
                }
            }
    }
    
}//End of class
