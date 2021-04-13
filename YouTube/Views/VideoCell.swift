//
//  VideoCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 09/04/21.
//

import UIKit

final class VideoCell: BaseCell {
    var video: Video? {
        didSet {
            // Configure NumberOfViews String
            if let video = video {
                if let title = video.title {
                    titleLabel.text = title
                    // Configure TitleLabel Height
                    let size = CGSize(width: frame.width - 32 - 44 - 8, height: 1000)
                    let estimatedRect = NSString(string: title).boundingRect(with: size, options: NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin), attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)], context: nil)
                    titleLabelHeightConstraint?.constant = estimatedRect.height > 20 ? 44 : 20
                }
                if let thumbnailImageName = video.thumbnailImageName {
                    thumbnailImageView.setImage(using: thumbnailImageName)
                }
            }
            if let channelImageName = video?.channel?.profileImageName {
                userProfileImageView.setImage(using: channelImageName)
            }
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            if let channelName = video?.channel?.name, let numberOfViews = video?.numberOfViews, let stringForNumberOfViews = formatter.string(from: numberOfViews) {
                subtitleTextView.text = "\(channelName) • \(stringForNumberOfViews) • 2 years ago"
            }
        }
    }
    
    private let thumbnailImageView: ImageView = {
        let imageView = ImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .fromRGBValue(red: 230, green: 230, blue: 230)
        return view
    }()
    
    private let userProfileImageView: ImageView = {
        let imageView = ImageView()
        imageView.layer.cornerRadius = 22
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.backgroundColor = .white
        label.textColor = .black
        return label
    }()
    private var titleLabelHeightConstraint: NSLayoutConstraint?
    
    private let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textColor = .lightGray
        textView.backgroundColor = .white
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        return textView
    }()
    
    override func configureCell() {
        super.configureCell()
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        addConstraints(withVisualFormat: "V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        addConstraints(withVisualFormat: "H:|-16-[v0]-16-|", views: thumbnailImageView)
        addConstraints(withVisualFormat: "H:|-16-[v0(44)]", views: userProfileImageView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: separatorView)
        
        for view in [titleLabel, subtitleTextView] {
            addConstraints([
                NSLayoutConstraint(item: view, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8),
                NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0)
            ])
        }
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: titleLabel, attribute: .height, multiplier: 0, constant: 20)
        addConstraints([
            NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8),
            NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4),
            titleLabelHeightConstraint!,
            NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: subtitleTextView, attribute: .height, multiplier: 0, constant: 30)
        ])
    }
}
