////
////  GoalController.swift
////  FamilyNight
////
////  Created by Jaymond Richardson on 6/11/21.
////
import Foundation

class GoalController {
    //MARK: - Shared Instance
    static let shared = GoalController()
    
    //MARK: - SOURCE OF TRUTH
    var goal: [Goal] = []
    
    
    //MARK: - CRUD FUNCTIONS
    func createGoal(for goal: Goal) {
        let goalToAdd: Goal = goal
        goa
    }
//    
//    func updateEvent(event: Event) {
//        let eventRef = db.collection("events").document(event.id)
//        eventRef.setData(["title" : event.title,
//                          "description" : event.description,
//                          "startDate" : event.startDate,
//                          "location" : event.location], merge: true)
//    }
//    
//    func delete(event: Event) {
//        db.collection("events").document(event.id).delete()
//        { err in
//            if let err = err {
//                print("Error removing document: \(err)")
//            } else {
//                print("Document successfully removed!")
//            }
//            guard let index = self.events.firstIndex(of: event) else {return}
//            self.events.remove(at: index)
//        }
//    }
//    
//    func fetchEvents(completion: @escaping (Bool) -> Void) {
//        db.collection("events").addSnapshotListener { snapshot, error in
//            self.events = [] //no duplicates
//            
//            if let error = error {
//                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//                return completion(false)
//            }
//            if let snapshot = snapshot {
//                for doc in snapshot.documents {
//                    
//                    let eventData = doc.data()
//                    let title = eventData["title"] as? String ?? ""
//                    let description = eventData["description"] as? String ?? ""
//                    let startDate: Date = Timestamp.dateValue(eventData["startDate"] as? Timestamp ?? Timestamp())()
//                    //                    let startDate = eventData["startDate"] as? Date ?? Date()
//                    
//                    let location = eventData["location"] as? String ?? ""
//                    let id = eventData["id"] as? String ?? ""
//                    
//                    let event = Event(title: title, description: description, startDate: startDate, location: location, id: id)
//                    self.events.append(event)
//                }
//                completion(true)
//            }
//        }
//    }
//    
//    func fetchEventWith(id: String, completion: @escaping (Bool) -> Void) {
//        db.collection("events").whereField("id", isEqualTo: id)
//            .getDocuments() { (querySnapshot, error) in
//                if let error = error {
//                    print("error getting docs: \(error)")
//                    return completion(false)
//                }
//                if let snapshot = querySnapshot {
//                    for doc in snapshot.documents {
//                        let eventData = doc.data()
//                        let title = eventData["title"] as? String ?? ""
//                        let description = eventData["description"] as? String ?? ""
//                        let startDate: Date = Timestamp.dateValue(eventData["startDate"] as? Timestamp ?? Timestamp())()
//                        let location = eventData["location"] as? String ?? ""
//                        let id = eventData["id"] as? String ?? ""
//                        
//                        let event = Event(title: title, description: description, startDate: startDate, location: location, id: id)
//                        self.eventDynamicLink = event
//                    }
//                    completion(true)
//                }
//            }
//    }
//    
//}//End of class
//
