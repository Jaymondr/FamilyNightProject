//
//  MainViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/25/21.
//

import UIKit
import Firebase
import FirebaseFirestore


class EventViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var planButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var familyTimeTitle: UILabel!
    @IBOutlet weak var subtitle: UILabel!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addColor()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setup()

    }
    
    //MARK: - Actions
    @IBAction func planButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Properties
    var events: [Event] = []
    var event: Event?
    let db = Firestore.firestore()
    
    //MARK: - Functions
    func addColor() {
        //Background Color
        view.backgroundColor = CustomColors.Blue
        //Plan Button
        self.planButton.setTitleColor(CustomColors.Tan, for: .normal)
        self.planButton.addCornerRadius()
        self.planButton.backgroundColor = CustomColors.GrayBlue
        //Family Title
        self.familyTimeTitle.textColor = CustomColors.Orange
        //TableView
        self.tableView.backgroundColor = CustomColors.Blue
        //Subtitle
        self.subtitle.textColor = CustomColors.Tan
        view.tintColor = CustomColors.Blue
        
    }
    
    //MARK: - Functions
    func setup() {
        DispatchQueue.main.async {
            EventController.shared.fetchEvents { success in
                if success {
                    print("Event Count: \(EventController.shared.events.count)")
                    self.events = EventController.shared.events
                    self.tableView.reloadData()
                } else {
                    print("Houston we have a problem!")
                }
            }
        }
    }
}//End of class

//MARK: - Extensions
extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        let event = EventController.shared.events[indexPath.row]//else {return UITableViewCell()}
        cell.textLabel?.text = event.title.uppercased()
        cell.detailTextLabel?.text = event.startDate.formatToString()
        cell.backgroundColor = CustomColors.Tan
        cell.textLabel?.textColor = CustomColors.GrayBlue
        cell.detailTextLabel?.textColor = CustomColors.GrayBlue
        cell.addRoundedCorner()
        
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPlannerDetailVC" {
            guard let destinationVC = segue.destination as? PlannerViewController,
                  let index = tableView.indexPathForSelectedRow else { return }
            let eventToSend = EventController.shared.events[index.row]
            destinationVC.event = eventToSend
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toPlannerDetailVC", sender: Any?.self)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let eventToDelete = EventController.shared.events[indexPath.row]
        EventController.shared.delete(event: eventToDelete)
        tableView.reloadData()
    }
  
}//End of extension


