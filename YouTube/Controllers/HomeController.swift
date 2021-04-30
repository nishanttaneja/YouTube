//
//  HomeController.swift
//  YouTube
//
//  Created by Nishant Taneja on 09/04/21.
//

import UIKit

final class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private let titles = ["Home", "Trending", "Subscriptions", "Account"]
    private let cellIdentifier = "cellId"
        
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureCollectionView()
        setupMenuBar()
    }
    
    private func configureNavigationController() {
        navigationController?.navigationBar.barTintColor = .red
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.white]
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home", style: .done, target: nil, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore)),
            UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        ]
    }
    
    @objc private func handleMore() {
        settingsLauncher.show()
    }
    
    @objc private func handleSearch() {  }
    
    private lazy var settingsLauncher: SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeViewController = self
        return launcher
    }()
    
    private func configureCollectionView() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .white
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
    
    private lazy var menuBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.homeController = self
        return menuBar
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        let redView = UIView()
        redView.backgroundColor = .red
        view.addSubview(redView)
        view.addSubview(menuBar)
        view.addConstraints(withVisualFormat: "H:|[v0]|", views: redView)
        view.addConstraints(withVisualFormat: "V:|[v0(50)]", views: redView)
        view.addConstraints(withVisualFormat: "H:|[v0]|", views: menuBar)
        view.addConstraints(withVisualFormat: "V:[v0(50)]", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
    //MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! FeedCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: view.frame.width, height: view.frame.height - 50 - view.safeAreaInsets.bottom)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.bottomBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = Int(targetContentOffset.pointee.x/view.frame.width)
        menuBar.collectionView.selectItem(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: [])
        updateTitleForIndex(index)
    }
}

extension HomeController {
    func scrollToIndex(_ index: Int) {
        collectionView.isPagingEnabled = false
        collectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredHorizontally, animated: true)
        collectionView.isPagingEnabled = true
        updateTitleForIndex(index)
    }
    
    func updateTitleForIndex(_ index: Int) {
        navigationItem.leftBarButtonItem?.title = titles[index]
    }
}

//MARK:- SettingsLauncher
extension HomeController {
    func showController(forSetting setting: Setting) {
        guard type(of: setting) != UITapGestureRecognizer.self else {
            return
        }
        let settingController = UIViewController()
        settingController.view.backgroundColor = .white
        settingController.navigationItem.title = setting.name.rawValue
        navigationController?.pushViewController(settingController, animated: true)
    }
}
