//
//  EdgeLabel.swift
//  Classified_Information
//
//  Created by wjq on 2017-11-27.
//  Copyright © 2017 wjq. All rights reserved.
//

import UIKit

class EdgeLabel: UILabel {
    
    open var edgeInsets: UIEdgeInsets = UIEdgeInsets.zero
    
    @IBInspectable  //Xib可视化
    var edgeLeft: CGFloat{
        get{ return edgeInsets.left }
        set{ edgeInsets.left = newValue }
    }
    @IBInspectable
    var edgeRight: CGFloat{
        get{ return edgeInsets.right }
        set{ edgeInsets.right = newValue }
    }
    @IBInspectable
    var edgeTop: CGFloat{
        get{ return edgeInsets.top }
        set{ edgeInsets.top = newValue }
    }
   
    @IBInspectable
    var edgeBottom: CGFloat {
        get { return edgeInsets.bottom }
        set { edgeInsets.bottom = newValue }
    }
    
    override func draw(_ rect: CGRect) {
        super.drawText(in: rect.inset(by: self.edgeInsets))
    }
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insets = self.edgeInsets
        var rect = super.textRect(forBounds: bounds.inset(by: insets), limitedToNumberOfLines: numberOfLines)
        rect.origin.x -= insets.left
        rect.origin.y -= insets.top
        rect.size.width += (insets.left + insets.right)
        rect.size.height += (insets.top + insets.bottom)
        return rect
    }
    
    public func setEdgeLabelStyle(textColor:UIColor? = nil, bgColor:UIColor? = nil) {
        self.textColor = textColor ?? UIColor.black
        self.backgroundColor = bgColor ?? UIColor.white
        self.layer.borderWidth = 1
        self.layer.borderColor = self.textColor?.cgColor
    }
}


extension UILabel {
    public func setAttributed(_ text : String? , line : CGFloat? = nil , alignment:NSTextAlignment? = nil)  {
        if let str = text {
            let attStr = NSMutableAttributedString(string: str )
            let parStyle = NSMutableParagraphStyle()
            parStyle.baseWritingDirection = .natural
            parStyle.alignment = alignment ?? .left
             parStyle.lineBreakMode = .byTruncatingTail
            parStyle.lineSpacing = line ?? 0
            
            attStr.addAttribute(NSAttributedString.Key.paragraphStyle, value: parStyle, range: NSMakeRange(0, str.count))
            self.attributedText = attStr
        }else{
            self.text = ""
        }
    }
    
   public func setAttribute(text: String, rangeString: String? = nil){
        if let rangeString = rangeString {
             let attributedString = NSMutableAttributedString(string: text)
            let range = attributedString.string.range(of: rangeString)
            let nsrange = attributedString.string.nsRange(from: range!)
            attributedString.addAttribute(.foregroundColor, value: UIColor.red, range: nsrange!)
            self.attributedText = attributedString
        }else{
            self.text = text
        }
    }
    
    
    
}

extension String{
    public func nsRange(from range: Range<String.Index>) -> NSRange? {
        let utf16view = self.utf16
        if let from = range.lowerBound.samePosition(in: utf16view), let to = range.upperBound.samePosition(in: utf16view) {
            return NSMakeRange(utf16view.distance(from: utf16view.startIndex, to: from), utf16view.distance(from: from, to: to))
        }
        return nil
    }
    
    // 设置label的高度
    public func contentHeight(titleText:String? , fontOfSize:CGFloat? = nil, line:CGFloat? = nil ,width : CGFloat? = nil) -> CGFloat {
        var frame = CGRect()
        let size = CGSize(width: width ?? UIScreen.main.bounds.size.width - 30, height: 0)  //设置label的最大宽度
        let parstyle = NSMutableParagraphStyle()
        parstyle.lineSpacing = line ?? 0
        let attributed = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: fontOfSize ?? 13),NSAttributedString.Key.paragraphStyle : parstyle]
        if let text = titleText {
            frame = text.boundingRect(with: size, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributed  , context: nil)
        }else{
            frame = CGRect.zero
        }
        let height = frame.size.height+10
        return height
    }
    
    
}

// Seystem Alert Font
extension UILabel {
    @objc dynamic var fontSize : CGFloat {
        get {
            return self.font.pointSize
        }
        set {
            self.font = self.font.withSize(newValue)
        }
    }
    @objc dynamic var appearanceFontName : String {
        get {
            return self.font.fontName
        }
        set {
            self.font = UIFont(name: newValue, size: self.font.pointSize)
        }
    }
    @objc dynamic var appearanceFont : UIFont! {
        get {
            return self.font
        }
        set {
            self.font = newValue
        }
    }
}


