//
//  VideoPlayerView.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    private var player: AVPlayer?
    private var isPlaying: Bool = false
    
    // Views
    private lazy var controlsContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0, alpha: 0.5)
        return view
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .white
        view.startAnimating()
        return view
    }()
    
    private lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause"), for: .normal)
        button.tintColor = .white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        return button
    }()
    
    private let videoDurationLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.textColor = .white
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let videoSlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .red
        slider.addTarget(self, action: #selector(handleSliderValueChange), for: .valueChanged)
        return slider
    }()
    
    // Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        configurePlayerView()
        configureControlsContainerView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension VideoPlayerView {
    private func configureControlsContainerView() {
        controlsContainerView.frame = frame
        addSubview(controlsContainerView)
        // Activity Indicator View
        controlsContainerView.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        // PlayPause Button
        controlsContainerView.addSubview(playPauseButton)
        playPauseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playPauseButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playPauseButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            playPauseButton.widthAnchor.constraint(equalToConstant: 50),
            playPauseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        // VideoDuration Label
        controlsContainerView.addSubview(videoDurationLabel)
        controlsContainerView.addSubview(videoSlider)
        NSLayoutConstraint.activate([
            videoDurationLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            videoDurationLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            videoDurationLabel.widthAnchor.constraint(equalToConstant: 48),
            videoDurationLabel.heightAnchor.constraint(equalToConstant: 24),
            // Video Slider
            videoSlider.leftAnchor.constraint(equalTo: leftAnchor),
            videoSlider.rightAnchor.constraint(equalTo: videoDurationLabel.leftAnchor),
            videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor),
            videoSlider.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
    
    private func configurePlayerView() {
        let urlString = "https://reflexioncdn.azureedge.net/contentdata/MEDIA/296/Proxy_Video/296_854x480.mp4"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            player?.play()
        }
    }
}
 
extension VideoPlayerView {
    @objc func handlePlayPause() {
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    @objc func handleSliderValueChange() {
        if let durationInSeconds = player?.currentItem?.duration.seconds {
            let seekTime = CMTime(seconds: durationInSeconds * Double(videoSlider.value), preferredTimescale: 1)
            player?.seek(to: seekTime)
        }
    }
}

extension VideoPlayerView {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsContainerView.backgroundColor = .clear
            isPlaying = true
            playPauseButton.isHidden = false
            if let durationInSeconds = player?.currentItem?.duration.seconds {
                let seconds = Int(durationInSeconds.truncatingRemainder(dividingBy: 60))
                let minutes = Int(durationInSeconds / 60)
                videoDurationLabel.text = "\(minutes):\(seconds)"
            }
        }
    }
}
