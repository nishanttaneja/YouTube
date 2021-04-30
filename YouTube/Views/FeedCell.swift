//
//  FeedCell.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import UIKit

class FeedCell: BaseCell {
    private let cellIdentifier = "cellId"
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    var videos = [Video]()
    
    override func configureCell() {
        super.configureCell()
        fetchVideos()
        addSubview(collectionView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraints(withVisualFormat: "V:|[v0]|", views: collectionView)
    }
    
    func fetchVideos() {
        ApiService.sharedInstance.fetchHomeFeed { [weak self] videos in
            self?.videos = videos
            self?.collectionView.reloadData()
        }
    }
}

//MARK:- UICollectionView
extension FeedCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! VideoCell
        if videos.count > indexPath.item {
            cell.video = videos[indexPath.item]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (frame.width - 32) * 9/16
        return CGSize(width: frame.width, height: height + 16 + 88)
    }
}
