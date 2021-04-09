//
//  VideoCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 09/04/21.
//

import UIKit

final class VideoCell: UICollectionViewCell {
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .red
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    private func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraints(withVisualFormat: "V:|-16-[v0]-8-[v1(44)]-16-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraints(withVisualFormat: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraints(withVisualFormat: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: separatorView)
        
        for view in [titleLabel, subtitleTextView] {
            addConstraints([
                NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8),
                NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0),
                NSLayoutConstraint(item: view, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
            ])
        }
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4)
        ])
    }
    
    func addConstraints(withVisualFormat format: String, views: UIView...) {
        var viewsDictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary.updateValue(view, forKey: "v\(index)")
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: .directionMask, metrics: nil, views: viewsDictionary))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
