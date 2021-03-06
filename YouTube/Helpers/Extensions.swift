//
//  Extensions.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

extension UIView {
    func addConstraints(withVisualFormat format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary.updateValue(view, forKey: "v\(index)")
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .directionMask, metrics: nil, views: viewsDictionary))
    }
}

extension UIColor {
    static func fromRGBValue(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        .init(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
