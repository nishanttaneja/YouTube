//
//  MenuBar.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

final class MenuBar: UIView {
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .red
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    private let imageNames: [String] = ["home", "trending", "subscriptions", "account"]
    
    private var bottomBarLeftAnchorConstraint: NSLayoutConstraint?
    
    private func setupeCollectionView() {
        addSubview(collectionView)
        addConstraints(withVisualFormat: "H:|[v0]|", views: collectionView)
        addConstraints(withVisualFormat: "V:|[v0]|", views: collectionView)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupeCollectionView()
        collectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .init())
        setupBottomBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: imageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width/4, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        bottomBarLeftAnchorConstraint?.constant = CGFloat(indexPath.item) * frame.width / 4
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.layoutIfNeeded()
        } completion: { _ in }
    }
}

//MARK:- BottomBar
extension MenuBar {
    func setupBottomBar() {
        let bottomBar = UIView()
        bottomBar.backgroundColor = .white
        bottomBar.layer.cornerRadius = 2
        bottomBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        bottomBar.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomBar)
        bottomBarLeftAnchorConstraint = bottomBar.leftAnchor.constraint(equalTo: leftAnchor)
        bottomBarLeftAnchorConstraint?.isActive = true
        NSLayoutConstraint.activate([
            bottomBar.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            bottomBar.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/4),
            bottomBar.heightAnchor.constraint(equalToConstant: 4)
        ])
    }
}
