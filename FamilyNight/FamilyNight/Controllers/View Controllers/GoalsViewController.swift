//
//  GoalsViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 5/26/21.
//

import UIKit

class GoalsViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    //MARK: - Outlets
    @IBOutlet weak var bigStar: UIImageView!
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var buttonWithTimer: UIButton!
    
        
    var pickerView: UIPickerView!
    var pickerData: [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView = UIPickerView(frame: CGRect(x: 10, y: 50, width: 250, height: 150))
        
    }
        
    //MARK: - Actions
    @IBAction func setGoalButtonTapped(_ sender: Any) {
        showAlert()
        pickerView.delegate = self
        pickerView.dataSource = self

        let minNum = 1
        let maxNum = 7
        
        pickerData = Array(stride(from: minNum, to: maxNum + 1, by: 1))
    }
    @IBAction func checkinButton(_ sender: Any) {
        self.buttonWithTimer.isEnabled = false
        Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {
             [weak self]timer in
            self?.buttonWithTimer.isEnabled = true
        }
        progressPercentage = 1.0 / Double(pickerValue)
        progressBar.progress += Float(progressPercentage)
        if progressBar.progress >= 0.1  && progressBar.progress <= 0.2 {
            percentLabel.text = "20%"

        } else
        if progressBar.progress >= 0.5 && progressBar.progress <= 0.89 {
            percentLabel.text = "50%"
            if starCount == 0 {
            self.star1.image = UIImage(systemName: "star.leadinghalf.fill")
            } else
            if starCount == 1 {
                self.star2.image = UIImage(systemName: "star.leadinghalf.fill")
            } else
            if starCount == 2 {
                self.star3.image = UIImage(systemName: "star.leadinghalf.fill")
            } else
            if starCount == 3 {
                self.star4.image = UIImage(systemName: "star.leadinghalf.fill")
            } else
            if starCount == 4 {
                self.bigStar.image = UIImage(systemName: "star.leadinghalf.fill")
            }
        } else
        if progressBar.progress >= 0.90 && progressBar.progress <= 0.99 {
            percentLabel.text = "99%"

        } else if
            progressBar.progress == 1 {
            if starCount == 0 {
                self.star1.image = UIImage(systemName: "star.fill")
                progressBar.progress = 0
                percentLabel.text = "0%"
                starCount += 1
            } else
            if starCount == 1 {
                self.star2.image = UIImage(systemName: "star.fill")
                progressBar.progress = 0
                percentLabel.text = "0%"
                starCount += 1
            } else
            if starCount == 2 {
                self.star3.image = UIImage(systemName: "star.fill")
                progressBar.progress = 0
                percentLabel.text = "0%"
                starCount += 1

            } else
            if starCount == 3 {
                self.star4.image = UIImage(systemName: "star.fill")
                progressBar.progress = 0
                percentLabel.text = "0%"
                starCount += 1

            } else
            if starCount == 4 {
                self.bigStar.image = UIImage(systemName: "star.fill")
                progressBar.progress = 0
                percentLabel.text = "0%"
                starCount += 1

            } else
            if starCount == 5 {
                starCount = 0
                star1.image = UIImage(systemName: "star")
                star2.image = UIImage(systemName: "star")
                star3.image = UIImage(systemName: "star")
                star4.image = UIImage(systemName: "star")
                bigStar.image = UIImage(systemName: "star")

            }
        }

    }
    
    //MARK: - Properties
    var pickerValue = 0
    var starCount = 0
    var pickedGoal = 5.00
    var progressPercentage: Double = 0.0


    
    //MARK: - Functions
    func addStyle() {
        self.bigStar.tintColor = CustomColors.Gold
        self.star1.tintColor = CustomColors.Gold
        self.star2.tintColor = CustomColors.Gold
        self.star3.tintColor = CustomColors.Gold
        self.star4.tintColor = CustomColors.Gold

    }
    func showAlert() {
        let ac = UIAlertController(title: "Choose Your Weekly Goal", message: "\n\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        ac.view.addSubview(pickerView)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            self.pickerValue = self.pickerData[self.pickerView.selectedRow(inComponent: 0)]
            print("Picker value: \(self.pickerValue) was selected")
        }))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(ac, animated: true)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(pickerData[row])"
    }
}//End of class
