//
//  CalendarViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/7/21.
//

import EventKit
import EventKitUI
import UIKit

class CalendarViewController: UIViewController, EKEventViewDelegate, EKCalendarChooserDelegate {
   
    
    
    let store = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        
    }
    
    @objc func didTapAdd() {
            
        store.requestAccess(to: .event) { [weak self] success, error in
            if success, error == nil {
                DispatchQueue.main.async {
                    guard let store = self?.store else {return}

                    let newEvent = EKEvent(eventStore: store)
                    newEvent.title = "Events Park play"
                    newEvent.startDate = Date()
                    newEvent.endDate = Date()

                    let otherVC = EKEventEditViewController()
                    otherVC.eventStore = store
                    otherVC.event = newEvent
                    self?.present(otherVC, animated: true, completion: nil)
                    
                }
            }
        }
        
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
