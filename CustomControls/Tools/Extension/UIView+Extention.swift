//
//  UIView+Extention.swift

//
//  Created by WJQ on 2017/8/8.
//  Copyright © 2017年 wjq. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    
    var wj_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    
    var wj_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    var middleX: CGFloat {
        get {
            return self.frame.midX
        }
        set {
            var frame  = self.frame
            frame.origin.x = newValue - frame.size.width/2
            self.frame = frame
        }
    }
    
    var middleY: CGFloat {
        get {
            return self.frame.midY
        }
        set {
            var frame  = self.frame
            frame.origin.y = newValue - frame.size.height/2
            self.frame = frame
        }
    }
    
    var max_X: CGFloat {
        get {
            return self.frame.maxX
        }
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
    }
    
    var max_Y: CGFloat {
        get {
            return self.frame.maxY
        }
        set {
            var frame  = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
    }
    
    var wj_centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    
    var wj_centerY: CGFloat {
        get {
            return center.y
        }
        set {
            center.y = newValue
        }
    }
    
    
    var wj_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }
    
    
    var wj_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    
    var wj_bottom: CGFloat {
        get {
            return wj_y + wj_height
        }
    }
    
    
    var wj_right: CGFloat {
        get{
            return wj_x + wj_width
        }
    }
    
    
    var wj_size: CGSize {
        get {
            return frame.size
        }
        set {
            frame.size = newValue
        }
    }
    
    func setAllAutosizingMasks() {
      autoresizingMask = [
        .flexibleLeftMargin,
        .flexibleRightMargin,
        .flexibleTopMargin,
        .flexibleBottomMargin,
        .flexibleWidth,
        .flexibleHeight
      ]
    }
}
