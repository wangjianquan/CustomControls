//
//  FloatTitleTextField.swift
//  CustomControls
//
//  Created by landixing on 2018/9/30.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class FloatTitleTextField: UITextField {
    
    let animationDuration = 0.3
    var titleLabel = UILabel()
    
    //MARK: 属性
    override var accessibilityLabel: String?{
        get{
            if let text = text, text.isEmpty {
                return titleLabel.text
            }else{
                return text
            }
        }
        set{
            self.accessibilityLabel = newValue
        }
    }

    override var placeholder: String?{
        didSet{
            titleLabel.text = placeholder
            titleLabel.sizeToFit()
        }
    }
    override var attributedPlaceholder: NSAttributedString?{
        didSet{
            titleLabel.text = attributedPlaceholder?.string
            titleLabel.sizeToFit()
        }
    }
    
    var titleFont: UIFont = UIFont.systemFont(ofSize: 12.0) {
        didSet{
            titleLabel.font = titleFont
            titleLabel.sizeToFit()
        }
    }
    
    //MARK: -- 间距
    @IBInspectable var hintPadding_Y: CGFloat = 0.0
    @IBInspectable var titlePadding_Y: CGFloat = 0.0 {
        didSet{
            var rect = titleLabel.frame
            rect.origin.y = titlePadding_Y
            titleLabel.frame = rect
        }
    }
    
    //MARK: -- (标题文字 在textfield未编辑情况的颜色)
    @IBInspectable var titleTextColour : UIColor = .gray{
        didSet{
            if !isFirstResponder {
                titleLabel.textColor = titleTextColour
            }
        }
    }
    //MARK: -- (标题文字 在textfield编辑情况的颜色)
    @IBInspectable var titleActiveTextColour : UIColor! {
        didSet{
            if isFirstResponder{
                titleLabel.textColor = titleActiveTextColour
            }
        }
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    fileprivate func setUpUI() {
        borderStyle = UITextField.BorderStyle.none
        titleActiveTextColour = tintColor
        titleLabel.alpha = 0
        titleLabel.font = titleFont
        titleLabel.textColor = titleTextColour
        if let str = placeholder, !str.isEmpty {
            titleLabel.text = str
            titleLabel.sizeToFit()
        }
        self.addSubview(titleLabel)
    }
    
    
    fileprivate func setTitlePositionForTextAlignment() {
        let rect = textRect(forBounds: bounds)
        var x = rect.origin.x
        if textAlignment == .center{
            x = rect.origin.x + rect.size.width * 0.5 - titleLabel.frame.size.width
        } else if textAlignment == .right {
            x = rect.origin.x + rect.size.width - titleLabel.frame.size.width
        }
        titleLabel.frame = CGRect(x: x, y: titleLabel.frame.origin.y, width: titleLabel.frame.size.width, height: titleLabel.frame.size.height)
    }
    fileprivate func maxTopInset() -> CGFloat {
        if let font = font {
            return max(0, floor(bounds.size.height - font.lineHeight - 4.0))
        }
        return 0.0
    }
    //MARK: -- 重写
    override func layoutSubviews() {
        super.layoutSubviews()
        setTitlePositionForTextAlignment()
        let isResp = isFirstResponder
        if let text = text, !text.isEmpty && isResp {
            titleLabel.textColor = titleActiveTextColour
        }else{
            titleLabel.textColor = titleTextColour
        }
        if let text = text, text.isEmpty {
            hideTitle(isResp)
        }else{
            showTitle(isResp)
        }
    }
    
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.textRect(forBounds: bounds)
        if let text = text, !text.isEmpty {
            var top = ceil(titleLabel.font.lineHeight + hintPadding_Y)
            top = min(top, maxTopInset())
            rect = bounds.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return rect.integral
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.editingRect(forBounds: bounds)
        if let text = text, !text.isEmpty {
            var top = ceil(titleLabel.font.lineHeight + hintPadding_Y)
            top = min(top, maxTopInset())
            rect = bounds.inset(by: UIEdgeInsets(top: top, left: 0.0, bottom: 0.0, right: 0.0))
        }
        return rect.integral
    }
    
    override func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        if let txt = text , !txt.isEmpty {
            var top = ceil(titleLabel.font.lineHeight + hintPadding_Y)
            top = min(top, maxTopInset())
            rect = CGRect(x:rect.origin.x, y:rect.origin.y + (top * 0.5), width:rect.size.width, height:rect.size.height)
        }
        return rect.integral
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


extension FloatTitleTextField {
    fileprivate func showTitle(_ animated: Bool) {
        let duration = animated ? animationDuration : 0
        UIView.animate(withDuration: duration, delay:0, options: [.beginFromCurrentState, .curveEaseInOut], animations:{
            self.titleLabel.alpha = 1.0
            var rect = self.titleLabel.frame
            rect.origin.y = self.titlePadding_Y
            self.titleLabel.frame = rect
        }, completion: nil)
    }
    
    fileprivate func hideTitle(_ animated: Bool){
        let duration = animated ? animationDuration : 0
        UIView.animate(withDuration: duration, delay:0, options: [.beginFromCurrentState, .curveEaseInOut], animations:{
            self.titleLabel.alpha = 0.0
            var rect = self.titleLabel.frame
            rect.origin.y = self.hintPadding_Y + self.titleLabel.font.lineHeight
            self.titleLabel.frame = rect
        }, completion: nil)
    }
    
}
