//
//  Setting.swift
//  YouTube
//
//  Created by Nishant Taneja on 13/04/21.
//

import UIKit

enum SettingName: String {
    case settings = "Settings"
    case termsAndPrivacy = "Terms & Privacy Policy"
    case feedback = "Send Feedback"
    case help = "Help"
    case switchAccount = "Switch Account"
    case cancel = "Cancel"
}

class Setting: NSObject {
    let name: SettingName
    let imageName: String
    
    required init(name: SettingName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}
