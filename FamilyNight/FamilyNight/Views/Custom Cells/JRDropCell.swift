//
//  JRDropCell.swift
//  FamilyNight
//
//  Created by Jaymond Richardson on 6/10/21.
//

import UIKit

class JRDropCell: UITableViewCell {
    var data: JRDropData? {
        didSet {
            guard let data = data else {return}
            self.title.text = data.title
            self.descriptive.text = data.description
        }
    }

    
    func animate() {
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
            self.contentView.layoutIfNeeded()
        })
    }
    
    fileprivate var title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.text = "Help & Information"
        label.textColor = CustomColors.GrayBlue
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let descriptive: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.text = "Enter description here..."
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = -1
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    fileprivate var container: UIView =
        {
            let v = UIView()
            v.translatesAutoresizingMaskIntoConstraints = false
            v.clipsToBounds = true
            v.backgroundColor = .lightGray
            v.layer.cornerRadius = 8
            return v
        }()
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(container)
        container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4).isActive = true
        container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4).isActive = true
        container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true

        container.addSubview(title)
        container.addSubview(descriptive)
        
        title.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        title.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4).isActive = true
        title.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4).isActive = true
        title.heightAnchor.constraint(equalToConstant: 60).isActive = true

        descriptive.topAnchor.constraint(equalTo: title.bottomAnchor).isActive = true
        descriptive.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 4).isActive = true
        descriptive.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -4).isActive = true
        descriptive.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
