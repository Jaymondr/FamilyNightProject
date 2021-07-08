//
//  Persistence.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 7/8/21.
////
//
//import Foundation
//
////MARK: - Persistence
//// CSL: create, Save, Load
//var events: [Event] = []
//
//func createPersistenceStore() -> URL {
//    let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    let fileURL = url[0].appendingPathComponent("FamilyNight.json")
//    return fileURL
//}
//
//func saveToPersistenceStore() {
//    do {
//        let data = try JSONEncoder().encode(events)
//        try data.write(to: createPersistenceStore())
//    } catch {
//        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//        
//    }
//}
//
//func loadFromPersistenceStore () {
//    do {
//        let data = try Data(contentsOf: createPersistenceStore())
//        events = try JSONDecoder().decode([Event].self, from: data)
//    } catch {
//        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
//    }
//}
//

