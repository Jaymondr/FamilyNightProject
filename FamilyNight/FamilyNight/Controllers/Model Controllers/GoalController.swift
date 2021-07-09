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
    var goals: [Goal] = []
    var goal: Goal?
    
    
    //MARK: - CRUD FUNCTIONS
    func createGoal(goal: Int, progress: Double) {
        let newGoal = Goal(goal: goal, progress: progress)
        goals.append(newGoal)
        EventController.shared.saveToPersistenceStore()
    }
    
    static func saveGoal(goal: Goal) {
        
    }
}//End of class
