//
//  UITableViewCell+extension.swift
//  rwmooc_Swift
//
//  Created by WJQ on 2019/12/18.
//  Copyright © 2019 wjq. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    class var reuse_identifier:String{
        return NSStringFromClass(self)
    }
    
}
