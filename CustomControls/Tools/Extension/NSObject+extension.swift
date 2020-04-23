//
//  NSObject+extension.swift
//  rwmooc_Swift
//
//  Created by WJQ on 2019/12/18.
//  Copyright © 2019 wjq. All rights reserved.
//

import Foundation
import UIKit

extension NSObject {
    private struct AssociatedKeys {
        static var spoc = false
        static var DescriptiveName = "nsh_DescriptiveName"

    }
   
    var isSPOC: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.spoc) as? Bool ?? AssociatedKeys.spoc
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject( self, &AssociatedKeys.spoc, newValue as Bool?, .OBJC_ASSOCIATION_ASSIGN)
            }
        }
    }
    
    
    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject( self,&AssociatedKeys.DescriptiveName,newValue as NSString?,.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    
    
    
}
