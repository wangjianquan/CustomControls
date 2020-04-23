//
//  UIColor+Extension.swift
//  CustomControls
//
//  Created by 白小嘿 on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation

extension  UIColor {
    
    /**
       // MARK: - 返回随机颜色
     */
    convenience init(r: CGFloat, g: CGFloat,  b: CGFloat,alpha:CGFloat? = nil) {
      self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha ?? 1.0)
    }

    convenience init(hex: Int) {
      self.init(r:CGFloat((hex >> 16) & 0xff), g:CGFloat((hex >> 8) & 0xff), b:CGFloat(hex & 0xff), alpha: 1.0)
    }
    
    
    /**
    // MARK: - 返回随机颜色
    */
    class var randomColor: UIColor {
       get {
           let red = CGFloat(arc4random()%256)/255.0
           let green = CGFloat(arc4random()%256)/255.0
           let blue = CGFloat(arc4random()%256)/255.0
           return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
       }
    }
    
    public static func hex(_ hex: Int, _ alpha: CGFloat) -> UIColor {
        let r = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let b = CGFloat((hex & 0xFF)) / 255.0
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }
    
    /**
       // MARK: - hex: Int
     */
    public static func hex(_ hex: Int) -> UIColor {
        return self.hex(hex, 1.0)
    }
    
    /**
      // MARK: - RGB
    */
    func RGB(r:CGFloat,g:CGFloat,b:CGFloat, _ alpha:CGFloat? = nil)-> UIColor{
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha ?? 1.0)
    }
    
    /**
       // MARK: - hex: Int
    */
    public static func color(_ color: UIColor, alpha: CGFloat) -> UIColor {
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        
        color.getRed(&red, green: &green, blue: &blue, alpha: nil)
        
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
    /**
       // MARK: - colorWithHexString : String
    */
    class func colorWithHexString(_ hex: String, alpha: CGFloat? = nil ) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        
        if (cString.count != 6) {
            return UIColor.gray
        }
        
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha ?? 1.0)
    }
    

   
}

