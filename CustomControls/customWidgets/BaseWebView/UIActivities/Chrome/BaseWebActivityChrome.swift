//
//  BaseWebActivityChrome.swift
//  CustomControls
//
//  Created by MacBook Pro on 2021/1/11.
//  Copyright © 2021 WJQ. All rights reserved.
//

import UIKit

class BaseWebActivityChrome: BaseWebActivity {
    
    override var activityTitle: String? {
        return "Open in Chrome"
    }
    
    override var activityImage: UIImage?{
        if UI_USER_INTERFACE_IDIOM() == .pad {
            return UIImage(named: "BaseWebActivityChrome" + "-iPad")
        } else {
            return UIImage(named: "BaseWebActivityChrome")
        }
    }
    
    override func canPerform(withActivityItems activityItems: [Any]) -> Bool {
        for item in activityItems {
            if item is URL {
                if UIApplication.shared.canOpenURL(URL(string: "googlechrome://")!) {
                    return true
                }
            }
        }
        return false
    }
    
    override func perform() {
        
        if let inputURL = self.URLToOpen {
            let scheme = inputURL.scheme;
            var chromeScheme: String? = nil
            
            if scheme == "http" {
                chromeScheme = "googlechrome"
            } else if scheme == "https" {
                chromeScheme = "googlechromes"
            }
            
            if let chromeScheme = chromeScheme {
                let absoluteString = inputURL.absoluteString
                let range = (absoluteString as NSString).range(of: ":")
                let urlNoScheme = (absoluteString as NSString).substring(from: range.location)
                let chromeURLString = chromeScheme + urlNoScheme
                let chromeURL = URL(string: chromeURLString)
                
                if let chromeURL = chromeURL {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(chromeURL, options:[:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(chromeURL)
                    }
                }
            }
        }
    }

}
