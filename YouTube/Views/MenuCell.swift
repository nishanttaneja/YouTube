//
//  MenuCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

final class MenuCell: BaseCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .fromRGBValue(red: 91, green: 14, blue: 13)
        return imageView
    }()
    
    override var isHighlighted: Bool {
        didSet {
            imageView.tintColor = isHighlighted ? .white : .fromRGBValue(red: 91, green: 14, blue: 13)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : .fromRGBValue(red: 91, green: 14, blue: 13)
        }
    }
    
    func configureImageView() {
        addSubview(imageView)
        addConstraints(withVisualFormat: "H:[v0(28)]", views: imageView)
        addConstraints(withVisualFormat: "V:[v0(28)]", views: imageView)
        addConstraints([
            NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        ])
    }
    
    override func configureCell() {
        super.configureCell()
        configureImageView()
    }
}
