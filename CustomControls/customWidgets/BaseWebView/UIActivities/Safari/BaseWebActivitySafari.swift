//
//  BaseWebActivitySafari.swift
//  CustomControls
//
//  Created by MacBook Pro on 2021/1/11.
//  Copyright © 2021 WJQ. All rights reserved.
//

import UIKit

class BaseWebActivitySafari: BaseWebActivity {
    
    
    override var activityTitle: String? {
        return "Open in Safari"
    }
    
    override var activityImage: UIImage?{
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return UIImage(named: "BaseWebActivitySafari" + "-iPad")
        } else {
            return UIImage(named: "BaseWebActivitySafari")
        }
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if item is URL {
                if UIApplication.shared.canOpenURL(item as! URL) {
                    return true
                }
            }
        }
        return false
    }
    
    override func perform() {
        if let URLToOpen = self.URLToOpen {
            var completed: Bool = true
            if #available(iOS 10, *) {
                UIApplication.shared.open(URLToOpen, options:[:], completionHandler: nil)
            } else {
                completed = UIApplication.shared.openURL(URLToOpen)
            }
            self.activityDidFinish(completed)
        }else{
            self.activityDidFinish(false)
        }
    }

}
