//
//  ApiService.swift
//  YouTube
//
//  Created by Nishant Taneja on 30/04/21.
//

import Foundation

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    private let baseURLString = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    
    private func fetchVideos(from urlString: String, completion: @escaping ([Video]) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil { print(error!.localizedDescription); return }
            guard data != nil else { return }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [Video]()
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
                    videos.append(video)
                }
                DispatchQueue.main.async {
                    completion(videos)
                }
            }
            catch { print(error.localizedDescription) }
        }.resume()
    }
}

extension ApiService {
    func fetchHomeFeed(completion: @escaping ([Video]) -> Void) {
        fetchVideos(from: baseURLString + "/home.json", completion: completion)
    }
    
    func fetchTrendingFeed(completion: @escaping ([Video]) -> Void) {
        fetchVideos(from: baseURLString + "/trending.json", completion: completion)
    }
    
    func fetchSubscriptionsFeed(completion: @escaping ([Video]) -> Void) {
        fetchVideos(from: baseURLString + "/subscriptions.json", completion: completion)
    }
}
