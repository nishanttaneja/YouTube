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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let videos = try decoder.decode([Video].self, from: data!)
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
