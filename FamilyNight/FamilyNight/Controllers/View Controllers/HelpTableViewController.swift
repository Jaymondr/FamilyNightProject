//
//  HelpTableViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/10/21.
//

import UIKit

struct JRDropData {
    var title: String
    var description: String
}

class HelpTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        assignbackground()
//        gradient.frame = view.bounds 
    }
    
    lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.gray.cgColor,
            UIColor.lightGray.cgColor,
            UIColor.darkGray.cgColor
        ]
        gradient.locations = [0, 0.25, 1]
        return gradient
    }()
    
    fileprivate func setupTableView() {
//        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        tableView.register(JRDropCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //MARK: - Properties
    var selectedIndex: IndexPath = IndexPath(row: 0, section: 0)

    let data = [
        JRDropData(title: "Overview", description: "Family Night is an easy to use app, that makes it simple to plan, attend and share an event over any platform. Once you've planned your event, hit the share button to send your event URL over multiple platforms"),
        JRDropData(title: "Comming Soon!", description: "Soon you will be able to create goals, and check in each time you follow through with an event. This is to help you create goals and follow through with them:)"),
        JRDropData(title: "Resources", description: "Using firebase data to create and send links to event"),
        JRDropData(title: "Privacy", description: "Your data is not collected by the Family Time App"),
        JRDropData(title: "Features", description: "Family Time is designed in a way that doesn't require an added social aspect. The point of family time is to create an event on an easy to use platform and send the event through a dynamic link using any social media platform you would like to use.")
    ]
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! JRDropCell
        cell.data = data[indexPath.row]
        cell.selectionStyle = .none
        cell.animate()
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if selectedIndex == indexPath {return 200}
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath
        tableView.beginUpdates()
        tableView.reloadRows(at: [selectedIndex], with: .none)
        tableView.endUpdates()
    }
    
    func assignbackground(){
        
        tableView.backgroundColor = CustomColors.lightgrayblue
          let background = UIImage(named: "graygradient")
          var imageView : UIImageView!
          imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
          imageView.clipsToBounds = true
          imageView.image = background
          imageView.center = view.center
//          view.addSubview(imageView)
//        view.insertSubview(imageView, at: 0)
//          self.view.sendSubviewToBack(imageView)
      }


    
}//End of class
