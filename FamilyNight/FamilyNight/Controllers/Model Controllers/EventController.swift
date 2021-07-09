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
    func createEvent(event: Event) {
        events.append(event)
        saveToPersistenceStore()
    }
    
    func createEventInFirebase(event: Event) {
        let eventRef = db.collection("events").document(event.id)
        eventRef.setData(["title" : event.title,
                         "description" : event.description,
                         "startDate" : event.startDate,
                         "location" : event.location])
        
    }
    
    func updateEventInFirebase(event: Event) {
        let eventRef = db.collection("events").document(event.id) //create a reference to an event and assign it to eventRef
        eventRef.setData(["title" : event.title,
                          "description" : event.description,
                          "startDate" : event.startDate,
                          "location" : event.location], merge: true)
    }
    
    func updateEvent(event: Event, title: String, description: String, startDate: Date, location: String) {
        event.title = title
        event.description = description
        event.startDate = startDate
        event.location = location
        saveToPersistenceStore()
    }
    
    func delete(event: Event) {
            self.db.collection("events").document(event.id).delete()
            
            guard let index = self.events.firstIndex(of: event) else {return}
            self.events.remove(at: index)
            self.saveToPersistenceStore()
            print("Document successfully removed!")
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
//        EventController.shared.loadFromPersistenceStore()
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
        EventController.shared.loadFromPersistenceStore()
    }
    func createPersistenceStore() -> URL {
        let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = url[0].appendingPathComponent("FamilyNight.json")
        return fileURL
    }

    func saveToPersistenceStore() {
        do {
            let data = try JSONEncoder().encode(events)
            try data.write(to: createPersistenceStore())
        } catch {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            
        }
    }

    func loadFromPersistenceStore () {
        do {
            let data = try Data(contentsOf: createPersistenceStore())
            let events = try JSONDecoder().decode([Event].self, from: data)
            self.events = events
        } catch {
            print("======== ERROR ========")
            print("Function: \(#function)")
            print("Error: \(error)")
            print("Description: \(error.localizedDescription)")
            print("======== ERROR ========")
        }
    }
}//End of class
