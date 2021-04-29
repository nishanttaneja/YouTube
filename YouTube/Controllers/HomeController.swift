//
//  HomeController.swift
//  YouTube
//
//  Created by Nishant Taneja on 09/04/21.
//

import UIKit

final class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    private var videos = [Video]()
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureCollectionView()
        setupMenuBar()
        fetchVideos()
    }
    
    private func fetchVideos() {
        guard let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json") else { return }
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            guard let self = self else { return }
            if error != nil { print(error!.localizedDescription); return }
            guard data != nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = []
                for dictionary in json as! [[String : Any]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    video.numberOfViews = dictionary["number_of_views"] as? NSNumber
                    if let channelJSON = dictionary["channel"] as? [String : Any] {
                        let channel = Channel()
                        channel.name = channelJSON["name"] as? String
                        channel.profileImageName = channelJSON["profile_image_name"] as? String
                        video.channel = channel
                    }
                    self.videos.append(video)
                }
            }
            catch { print(error.localizedDescription) }
            DispatchQueue.main.async { [weak self] in
                self?.collectionView.reloadData()
            }
        }.resume()
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
    
    //MARK:- CollectionView
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 32) * 9/16
        return CGSize(width: view.frame.width, height: height + 16 + 88)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
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
