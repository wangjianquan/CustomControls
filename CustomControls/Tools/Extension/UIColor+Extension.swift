//
//  UIColor+Extension.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation

extension  UIColor {

      convenience init(r : Int, g : Int,  b : Int) {
            self.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1.0)
      }

      convenience init(hex: Int) {
            self.init(r:(hex >> 16) & 0xff, g:(hex >> 8) & 0xff, b:hex & 0xff)
      }
}

