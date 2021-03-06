//
//  Event.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/25/21.
//

import Foundation
import UIKit

//SKU secretNameThatICameUpWith
class Event: Codable {
    var title: String
    var description: String
    var startDate: Date
    var endDate: Date
    var location: String
    var id: String
    
    init(title: String, description: String, startDate: Date, endDate: Date, location: String, id: String = UUID().uuidString) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
        self.location = location
        self.id = id
    }
    
}//End of class

//MARK: - Extensions

extension Event: Equatable {
    static func == (lhs: Event, rhs: Event) -> Bool {
        return lhs.id == rhs.id
    }
} //End of extension

class Goal {
    var goal: Int
    var progress: Double
    init(goal: Int, progress: Double) {
    self.goal = goal
    self.progress = progress
    }
}


