//
//  SettingsLauncher.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

class SettingsLauncher: NSObject {
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0, alpha: 0.5)
        view.alpha = 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
        return view
    }()
    
    private let cellId = "cellId"
    private let cellHeight: CGFloat = 50
    let settings: [Setting] = [
        Setting(name: "Settings", imageName: "settings"),
        Setting(name: "Terms & privacy policy", imageName: "privacy"),
        Setting(name: "Send Feedback", imageName: "feedback"),
        Setting(name: "Help", imageName: "help"),
        Setting(name: "Switch Account", imageName: "switch_account"),
        Setting(name: "Cancel", imageName: "cancel")
    ]
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "cellId")
        return collectionView
    }()
    
    var homeViewController: HomeController?
    
    func show() {
        if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
            window.addSubview(backgroundView)
            window.addSubview(collectionView)
            backgroundView.frame = window.frame
            collectionView.frame.size = CGSize(width: window.frame.width, height: cellHeight * CGFloat(settings.count))
            collectionView.frame.origin = CGPoint(x: 0, y: window.frame.height)
        }
        // Animation
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.backgroundView.alpha = 1
            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                self?.collectionView.frame.origin.y = window.frame.height - (self?.collectionView.frame.height ?? 0)
            }
        }
    }
    
    @objc func handleDismiss(withSetting setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut) { [weak self] in
            self?.backgroundView.alpha = 0
            if let window = UIApplication.shared.windows.filter({ $0.isKeyWindow }).first {
                self?.collectionView.frame.origin.y = window.frame.height
            }
        } completion: { [weak self] (success) in
            self?.backgroundView.removeFromSuperview()
            self?.collectionView.removeFromSuperview()
            if setting.name != "" && setting.name != "Cancel" {
                self?.homeViewController?.showController(forSetting: setting)
            }
        }
    }
}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.item]
        return cell
    }
    
    // DelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    //Delegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = settings[indexPath.item]
        handleDismiss(withSetting: setting)
    }
}
