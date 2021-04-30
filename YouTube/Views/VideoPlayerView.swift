//
//  VideoPlayerView.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        let urlString = "https://reflexioncdn.azureedge.net/contentdata/MEDIA/296/Proxy_Video/296_854x480.mp4"
        if let url = URL(string: urlString) {
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
