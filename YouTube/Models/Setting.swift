//
//  Setting.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

class Setting: NSObject {
    let name: String
    let imageName: String
    
    required init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
