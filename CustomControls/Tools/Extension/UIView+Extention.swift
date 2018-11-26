//
//  UIView+Extention.swift
//  1-TableView使用
//
//  Created by apple on 2017/8/8.
//  Copyright © 2017年 HEJJY. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable
    var width : CGFloat{
        get{ return self.frame.width }
        set{
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }
    @IBInspectable
    var height : CGFloat{
        get{ return self.frame.height }
        set{
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }
    @IBInspectable
    var x : CGFloat{
        get{ return self.frame.origin.x }
        set{
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
    }
    @IBInspectable
    var y : CGFloat{
        get{ return self.frame.origin.y }
        set{
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
    }
    @IBInspectable
    var size : CGSize {
        
        get { return self.frame.size }
        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
    @IBInspectable
    var centerX : CGFloat{
        get { return self.center.x }
        set{
            var center = self.center
            center.x = newValue
            self.center = center
        }
    }
    @IBInspectable
    var centerY : CGFloat{
        get { return self.center.x }
        set{
            var center = self.center
            center.y = newValue
            self.center = center
        }
    }

}
