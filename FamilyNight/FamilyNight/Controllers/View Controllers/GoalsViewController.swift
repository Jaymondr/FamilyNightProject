//
//  GoalsViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/26/21.
//

import UIKit

class GoalsViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var bigStar: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addStyle()
    }
    
    
    
    
    //MARK: - Functions
    func addStyle() {
        self.bigStar.tintColor = CustomColors.Gold
        self.star1.tintColor = CustomColors.Gold
        self.star2.tintColor = CustomColors.Gold
        self.star3.tintColor = CustomColors.Gold
        self.star4.tintColor = CustomColors.Gold

    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
