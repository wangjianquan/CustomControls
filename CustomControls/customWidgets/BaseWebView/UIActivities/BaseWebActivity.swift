//
//  BaseWebActivity.swift
//  CustomControls
//
//  Created by MacBook Pro on 2021/1/11.
//  Copyright © 2021 WJQ. All rights reserved.
//

import UIKit

class BaseWebActivity: UIActivity {

    var URLToOpen: URL? = nil
    let schemePrefix: String? = nil
    
    override var activityType: UIActivity.ActivityType?{
        return UIActivity.ActivityType(rawValue: NSStringFromClass(type(of: self).self))
    }
    
    override func prepare(withActivityItems activityItems: [Any]) {
        for item in activityItems {
            if item is URL {
                URLToOpen = item as? URL
            }
        }
        
    }
}
