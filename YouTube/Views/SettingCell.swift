//
//  SettingCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

final class SettingCell: BaseCell {
    var setting: Setting? {
        didSet {
            titleLabel.text = setting?.name.rawValue
            if let imageName = setting?.imageName {
                iconImageView.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? .darkGray : .white
            iconImageView.tintColor = isHighlighted ? .white : .darkGray
            titleLabel.textColor = isHighlighted ? .white : .black
        }
    }
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .black
        return label
    }()
    
    override func configureCell() {
        super.configureCell()
        // Subviews
        addSubview(iconImageView)
        addSubview(titleLabel)
        // Constraints
        addConstraints(withVisualFormat: "H:|-8-[v0(30)]-8-[v1]|", views: iconImageView, titleLabel)
        addConstraints(withVisualFormat: "V:|[v0]|", views: titleLabel)
        addConstraints(withVisualFormat: "V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
    }
}
