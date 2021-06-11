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
        
//        let vc = EKCalendarChooser()
//        vc.showsDoneButton = true
//        vc.showsDoneButton = true
//        vc.delegate = self
//        present(UINavigationController(rootViewController: vc), animated: true)
        
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
                    
                    //                let vc = EKEventViewController()
                    //                vc.delegate = self
                    //                vc.event = newEvent
                    //                let navVC = UINavigationController(rootViewController: vc)
                    //                self?.present(navVC, animated: true)
                }
            }
        }
        
    }
    
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
        
    }
}
