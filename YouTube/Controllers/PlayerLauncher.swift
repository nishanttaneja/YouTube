//
//  PlayerLauncher.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit

class PlayerLauncher: NSObject {
    // Views
    let windowFrame = UIApplication.shared.windows.first!.safeAreaLayoutGuide.layoutFrame
    lazy private var view: UIView = {
        let windowMaxPoint = CGPoint(x: windowFrame.width, y: windowFrame.height)
        let view = UIView(frame: .init(origin: windowMaxPoint, size: .zero))
        view.backgroundColor = UIColor.white
        UIApplication.shared.windows.first?.addSubview(view)
        return view
    }()
    
    func showVideoPlayer() {
        let playerSize = CGSize(width: self.windowFrame.width, height: self.windowFrame.width * 9 / 16)
        let playerView = VideoPlayerView(frame: CGRect(origin: .zero, size: playerSize))
        view.addSubview(playerView)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = self.windowFrame
        }, completion: nil)
    }
}
