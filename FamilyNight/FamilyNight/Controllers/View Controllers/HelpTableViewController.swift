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
        JRDropData(title: "Overview", description: "OverView description here, gonna say some stuff type some stuff to see what it looks like with a lot of info in it bla yimma yamma"),
        JRDropData(title: "What's New?", description: "Whats new to my app... coming soon!"),
        JRDropData(title: "Resources", description: "Where did i get my stuff? Powered by who, yidda yadda"),
        JRDropData(title: "Privacy", description: "Notify what types and the uses of the data that is being gathered. Must accurately reflect the apps data"),
        JRDropData(title: "Features", description: "Epxplain cool features here...")
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
