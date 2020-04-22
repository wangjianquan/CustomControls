//
//  MBProgressHUD.swift
//  CustomControls
//
//  Created by WJQ on 2019/12/26.
//  Copyright © 2019 WJQ. All rights reserved.
//

import Foundation

public enum HUDMessagePosition {
    case top
    case bottom
}


extension MBProgressHUD {
    
    class func showLoading(text: String? = nil, detailText: String? = nil, _ contentColor:UIColor? = nil) {
        let window = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to:window!, animated: true)
        if let loadingText = text {
            hud.label.text = loadingText
        }
        if let detailText = detailText {
            hud.detailsLabel.text = detailText
        }
        if let color = contentColor {
            hud.contentColor = color;
        }
        
    }
    
    class func showMessage(_ text: String, _ position: HUDMessagePosition? = nil, toView: UIView? = nil){
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            let hud = MBProgressHUD.showAdded(to: toView ?? window!, animated: true)
            hud.label.text = text
            hud.label.textColor = .white
            let screenHeight = UIScreen.main.bounds.size.height
            if toView == nil || toView == window {
                switch position {
                case .top:
                    hud.offset = CGPoint(x: 0, y: -(screenHeight/3))
                case .bottom:
                    hud.offset = CGPoint(x: 0, y: screenHeight/3)
                default :
                    break
                }
            }
            hud.mode = .text
            hud.animationType = .fade
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1.5)
        }
    }
    
    class func showError(_ error: String, toView: UIView? = nil) {
        self.stateIcon(error, toView: toView, "error")
    }
    
    class func showSuccess(_ success: String, toView: UIView? = nil) {
        self.stateIcon(success, toView: toView, "success")
    }
    
    fileprivate class func stateIcon(_ text: String, toView: UIView? = nil, _ icon: String){
        let window = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: toView ?? window!, animated: true)
        hud.label.text = text
        hud.label.textColor = UIColor(white: 1, alpha: 0.7)
        let imageView = UIImageView(image: UIImage(named: "MBProgressHUD.bundle/\(icon).png"))
        hud.mode = .customView
        hud.customView = imageView
        hud.isSquare = true
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay:1.5)
    }
    
    class  func hide(formView: UIView? = nil, animated: Bool) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            MBProgressHUD.hide(for: formView ?? window!, animated: animated)
        }
    }
}
