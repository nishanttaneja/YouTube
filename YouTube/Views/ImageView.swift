//
//  ImageView.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

final class ImageView: UIImageView {
    private var urlString: String?
    
    func setImage(using urlString: String) {
        image = nil
        if let savedImage = imageCache.object(forKey: NSString(string: urlString)) {
            image = savedImage
            return
        }
        self.urlString = urlString
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { print(error!.localizedDescription); return }
            guard let downloadedImage = UIImage(data: data!) else { return }
            if self.urlString == urlString {
                DispatchQueue.main.async {
                    self.image = downloadedImage
                }
            }
            imageCache.setObject(downloadedImage, forKey: NSString(string: urlString))
        }.resume()
    }
}
