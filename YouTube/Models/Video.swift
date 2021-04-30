//
//  Video.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import Foundation

struct Video: Decodable {
    let title: String?
    let thumbnailImageName: String?
    let channel: Channel?
    let numberOfViews: Int?
}

struct Channel: Decodable {
    let name: String?
    let profileImageName: String?
}
