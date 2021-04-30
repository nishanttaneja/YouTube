//
//  TrendingCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit

class TrendingCell: FeedCell {
    override func fetchVideos() {
        ApiService.sharedInstance.fetchTrendingFeed { videos in
            self.videos = videos
            self.collectionView.reloadData()
        }
    }
}
