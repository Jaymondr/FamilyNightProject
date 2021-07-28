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
    @IBOutlet weak var goalsButton: UITabBarItem!
    @IBOutlet weak var helpButton: UITabBarItem!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true

        addStyle()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
        EventController.shared.loadFromPersistenceStore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        EventController.shared.loadFromPersistenceStore()
        tableView.reloadData()
        setup()
    }
    
    //MARK: - Actions
    @IBAction func planButtonTapped(_ sender: Any) {
        
    }
    
    //MARK: - Properties
    var events = EventController.shared.events
    var event: Event?
    let db = Firestore.firestore()
    var window: UIWindow?
    
    //MARK: - Functions
   private func addStyle() {
        assignbackground()
//        goalsButton.badgeColor = .systemYellow
        helpButton.badgeColor = CustomColors.GrayBlue
        //Plan Button
        self.planButton.setTitleColor(CustomColors.DarkBlue, for: .normal)
        self.planButton.addCornerRadius()
        self.planButton.backgroundColor = CustomColors.Orange
        self.planButton.layer.borderWidth = 1
        self.planButton.layer.borderColor = .none
        //Family Title
        self.familyTimeTitle.textColor = CustomColors.GrayBlue
        self.tableView.backgroundColor = UIColor.clear
        //Subtitle
        self.subtitle.textColor = CustomColors.Gray
        view.tintColor = CustomColors.Blue
    }
    func assignbackground(){
          let background = UIImage(named: "launchScreenImage")

          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
          view.addSubview(imageView)
          self.view.sendSubviewToBack(imageView)
      }
    
    //MARK: - Functions
    func setup() {
        DispatchQueue.main.async {
            EventController.shared.loadFromPersistenceStore()
            self.events = EventController.shared.events
            self.tableView.reloadData()
        }
    }
}//End of class

//MARK: - Extensions
extension EventViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventController.shared.events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath)
        
        let event = EventController.shared.events[indexPath.row]//else {return UITableViewCell()}
        cell.textLabel?.text = event.title.uppercased()
        cell.detailTextLabel?.text = event.startDate.formatToString()
        cell.backgroundColor = UIColor.clear
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
        if editingStyle == .delete {
        let eventToDelete = EventController.shared.events[indexPath.row]
        EventController.shared.delete(event: eventToDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
  
}//End of extension


