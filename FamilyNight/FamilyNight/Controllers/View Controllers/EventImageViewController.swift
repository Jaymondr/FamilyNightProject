//
//  EventImageViewController.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/7/21.
//

import UIKit


class EventImageViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var imageView: UIImageView!
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
//        addImage()
        addTitle()
//        drawCircle()

    }
    
    //MARK: - Properties
    var event: Event?
    
    //MARK: - Functions
    func addImage() {
        addTitle()
    }
    
    func addTitle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 45),
                .paragraphStyle:paragraphStyle,
                .strokeColor: UIColor.systemRed
                    
            ]
            let title = event?.title
            
            let attributedString = NSAttributedString(string: title ?? "Unable To Fetch Title", attributes: attrs)
            attributedString.draw(with: CGRect(x: 100, y: 32, width: 200, height: 200), options: .usesLineFragmentOrigin, context: nil)
            
        }
        imageView.image = image
    }
    func drawCircle() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        let image = renderer.image { ctx in
            let circle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.blue.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            ctx.cgContext.addEllipse(in: circle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = image
        
    }


}
