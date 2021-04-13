//
//  HomeController.swift
//  YouTube
//
//  Created by Nishant Taneja on 09/04/21.
//

import UIKit

final class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //MARK:- View Lifecycle
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = .white
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private let menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.backgroundColor = .blue
        return menuBar
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraints(withVisualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraints(withVisualFormat: "V:|[v0(50)]", views: menuBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureCollectionView()
        setupMenuBar()
    }
    
    //MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
