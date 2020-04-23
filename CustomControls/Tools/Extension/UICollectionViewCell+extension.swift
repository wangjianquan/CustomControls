//
//  UICollectionViewCell+extension.swift
//  rwmooc_Swift
//
//  Created by WJQ on 2019/12/18.
//  Copyright © 2019 wjq. All rights reserved.
//

import UIKit

extension UICollectionViewCell {

    class var reuse_identifier: String{
        return NSStringFromClass(self)
    }
    
}
