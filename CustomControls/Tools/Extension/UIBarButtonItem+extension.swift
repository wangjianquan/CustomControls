//
//  UIBarButtonItem+extension.swift
//  rwmooc_Swift
//
//  Created by WJQ on 2019/12/19.
//  Copyright © 2019 wjq. All rights reserved.
//

import UIKit

extension UIBarButtonItem{
    /**
     * 便利构造函数 convenience , self.init
     */
    convenience init(imageName : String ,target: Any?, action: Selector) {
        let btn = UIButton()
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: imageName), for: .highlighted)
        btn.addTarget(target, action: action, for: .touchUpInside)
        btn.sizeToFit()
        self.init(customView : btn)
    }
    
}

