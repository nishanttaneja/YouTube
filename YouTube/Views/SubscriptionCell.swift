//
//  SubscriptionCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit

class SubscriptionCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionsFeed { videos in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
