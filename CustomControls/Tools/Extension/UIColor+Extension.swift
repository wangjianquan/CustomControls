//
//  UIColor+Extension.swift
//  CustomControls
//
//  Created by 白小嘿 on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation

extension  UIColor {

    convenience init(r: CGFloat, g: CGFloat,  b: CGFloat,alpha:CGFloat? = nil) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha ?? 1.0)
      }

      convenience init(hex: Int) {
        self.init(r:CGFloat((hex >> 16) & 0xff), g:CGFloat((hex >> 8) & 0xff), b:CGFloat(hex & 0xff), alpha: 1.0)
      }
}

