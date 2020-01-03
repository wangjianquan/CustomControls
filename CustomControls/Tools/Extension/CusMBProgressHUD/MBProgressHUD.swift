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
    
    class func showMessage(_ text: String, _ position: HUDMessagePosition? = nil, toView: UIView? = nil){
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            let hud = MBProgressHUD.showAdded(to: toView ?? window!, animated: true)
            hud.label.text = text
            hud.label.textColor = UIColor(white: 1, alpha: 0.7)
            hud.bezelView.color = .white
            if toView == nil || toView == window {
                switch position {
                case .top:
                    hud.offset = CGPoint(x: 0, y: -230)
                case .bottom:
                    hud.offset = CGPoint(x: 0, y: 230)
                default :
                    break
                }
            }
            hud.mode = .text
            hud.animationType = .zoomOut
            hud.removeFromSuperViewOnHide = true
            hud.hide(animated: true, afterDelay: 1)
        }
    }
    
    class func showError(_ error: String, toView: UIView? = nil) {
        self.stateIcon(error, toView: toView, "error")
    }
    
    class func showSuccess(_ success: String, toView: UIView? = nil) {
        self.stateIcon(success, toView: toView, "success")
    }
    
    class  func hide(formView: UIView?, animated: Bool) {
        DispatchQueue.main.async {
            let window = UIApplication.shared.keyWindow
            MBProgressHUD.hide(for: formView ?? window!, animated: animated)
        }
    }
    
    fileprivate class func stateIcon(_ text: String, toView: UIView? = nil, _ icon: String){
        let window = UIApplication.shared.keyWindow
        let hud = MBProgressHUD.showAdded(to: toView ?? window!, animated: true)
        hud.label.text = text
        hud.label.textColor = UIColor(white: 1, alpha: 0.7)
        hud.customView = UIImageView(image: UIImage(named: icon))
        hud.mode = .customView
//        hud.isSquare = true
        hud.removeFromSuperViewOnHide = true
        hud.hide(animated: true, afterDelay:2.3)
    }
}
