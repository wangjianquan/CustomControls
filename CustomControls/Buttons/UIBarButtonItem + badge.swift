//
//  UIBarButtonItem + badge.swift
//  CustomControls
//
//  Created by aixuexue on 2018/12/27.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation

private var UIBarButtonItem_badgeKey : Void?
private var UIBarButtonItem_badgeBGColorKey : Void?
private var UIBarButtonItem_badgeTextColorKey : Void?
private var UIBarButtonItem_badgeFontKey : Void?
private var UIBarButtonItem_badgePaddingKey : Void?
private var UIBarButtonItem_badgeMinSizeKey : Void?
private var UIBarButtonItem_badgeOriginXKey : Void?
private var UIBarButtonItem_badgeOriginYKey : Void?
private var UIBarButtonItem_shouldHideBadgeAtZeroKey : Void?
private var UIBarButtonItem_shouldAnimateBadgeKey : Void?
private var UIBarButtonItem_badgeValueKey : Void?

extension UIBarButtonItem  {
    var badgeLabel: UILabel? {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeKey) as? UILabel
        }
        set{
            if let value = newValue {
                objc_setAssociatedObject(self, &UIBarButtonItem_badgeKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
    // Badge value to be display
    var badgeValue : String? {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeValueKey) as? String
        }
        set(badgeValue){
                objc_setAssociatedObject(self, &UIBarButtonItem_badgeValueKey, badgeValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
                updateBadgeValue(animated: true)
                refreshBadge()

            if (badgeValue?.isEmpty)!   || (badgeValue == "") || ((badgeValue == "0") && shouldHideBadgeAtZero) {
                removeBadge()
            } else if (self.badgeLabel == nil ) {

                self.badgeLabel  = UILabel(frame: CGRect(x: self.badgeOriginX , y: self.badgeOriginY, width: 20, height: 20))
                self.badgeLabel?.textColor = self.badgeTextColor
                self.badgeLabel?.backgroundColor = self.badgeBGColor
                self.badgeLabel?.font = self.badgeFont
                self.badgeLabel?.textAlignment = .center
                badgeInit()
                addSubview(self.badgeLabel!)
                updateBadgeValue(animated: false)
            } else {
                updateBadgeValue(animated: true)
            }
        }
    }

    /**
     * Badge background color
     */
    var badgeBGColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey) as? UIColor ?? .red
        }
        set {
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeBGColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { refreshBadge() }
        }
    }

    /**
     * Badge text color
     */

    var badgeTextColor: UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey) as? UIColor ?? .white
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeTextColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) {  refreshBadge() }
        }
    }


    /**
     * Badge font
     */
    var badgeFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeFontKey) as? UIFont ?? UIFont.systemFont(ofSize: 12)
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeFontKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { refreshBadge() }
        }
    }

    /**
     *  Padding value for the badge
     */
    var badgePadding: CGFloat {
        get{
            return  objc_getAssociatedObject(self, &UIBarButtonItem_badgePaddingKey) as? CGFloat ?? 6
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgePaddingKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { updateBadgeFrame() }
        }
    }

    /**
     * badgeLabel 最小尺寸
     */
    var badgeMinSize: CGFloat {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey) as? CGFloat ?? 8
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeMinSizeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { updateBadgeFrame() }
        }
    }

    /**
     *  badgeLabel OriginX
     */
    var badgeOriginX: CGFloat {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey) as? CGFloat ?? 0
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginXKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { updateBadgeFrame() }
        }
    }

    /**
     * badgeLabel OriginY
     */
    var badgeOriginY: CGFloat  {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey) as? CGFloat ?? -4
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_badgeOriginYKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badgeLabel != nil) { updateBadgeFrame() }
        }
    }

    /**
     * In case of numbers, remove the badge when reaching zero
     */
    var shouldHideBadgeAtZero: Bool  {
        get {
            return objc_getAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &UIBarButtonItem_shouldHideBadgeAtZeroKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
             if (self.badgeLabel != nil) { refreshBadge() }
        }
    }

    /**
     * Badge has a bounce animation when value changes
     */
    var shouldAnimateBadge: Bool {
        get{
            return objc_getAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey) as? Bool ?? true
        }
        set{
            objc_setAssociatedObject(self, &UIBarButtonItem_shouldAnimateBadgeKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
             if (self.badgeLabel != nil) { refreshBadge() }
        }
    }



    fileprivate func badgeInit()  {

        var superview: UIView? = nil
        var defaultOriginX: CGFloat = 0
        if customView != nil {
            superview = customView
            if let label = self.badgeLabel {
                defaultOriginX = (superview?.frame.size.width ?? 0.0) - label.frame.size.width / 2
            }
            superview?.clipsToBounds = false
        } else if NSObject.responds(to: #selector(self.view)) && self?.view() != nil {
            superview = self.view
            defaultOriginX = superview.frame.size.width - (badgeLabel?.frame.size.width)!
        }
        superview?.addSubview(badgeLabel!)



        self.badgeOriginX   = defaultOriginX;

    }

    fileprivate func refreshBadge() {
        guard let tempLabel = self.badgeLabel else { return }
        tempLabel.textColor = self.badgeTextColor
        tempLabel.backgroundColor  = self.badgeBGColor
        tempLabel.font  = self.badgeFont
    }

    fileprivate func removeBadge() {
        UIView.animate(withDuration: 0.2, animations: {
            self.badgeLabel?.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }) { (finished: Bool) in
            self.badgeLabel?.removeFromSuperview()
            if (self.badgeLabel != nil) { self.badgeLabel = nil }
        }
    }



    fileprivate func updateBadgeValue(animated: Bool) {
        if animated && self.shouldAnimateBadge && !(self.badgeLabel?.text == self.badgeValue) {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1.5
            animation.toValue = 1
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1.0, 1.0)
            self.badgeLabel?.layer.add(animation, forKey: "bounceAnimation")
        }

        var badgeValue = 0
        if let badgeStr = self.badgeValue , let value = Int(badgeStr) {
            badgeValue = value
        }
        self.badgeLabel?.text = badgeValue >= 99 ? "99+" : self.badgeValue
        self.badgeLabel?.text =  self.badgeValue
        let duration: TimeInterval = (animated && self.shouldAnimateBadge) ? 0.2 : 0
        UIView.animate(withDuration: duration, animations: {
            self.updateBadgeFrame()
        })
    }

    fileprivate  func updateBadgeFrame() {
        let expectedLabelSize: CGSize = badgeExpectedSize()
        var minHeight: CGFloat = expectedLabelSize.height
        minHeight = (minHeight < badgeMinSize) ? badgeMinSize : expectedLabelSize.height
        var minWidth: CGFloat = expectedLabelSize.width
        let padding = self.badgePadding
        minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width
        self.badgeLabel?.frame = CGRect(x: self.badgeOriginX, y: self.badgeOriginY, width: minWidth + padding, height: minHeight + padding)
        self.badgeLabel?.layer.cornerRadius = (minHeight + padding) / 2
        self.badgeLabel?.layer.masksToBounds = true
    }

    fileprivate func badgeExpectedSize() -> CGSize {
        let frameLabel: UILabel = duplicate(self.badgeLabel)
        frameLabel.sizeToFit()
        let expectedLabelSize: CGSize = frameLabel.frame.size
        return expectedLabelSize
    }

    fileprivate func duplicate(_ labelToCopy: UILabel? ) -> UILabel {
        guard let temp = labelToCopy else { fatalError("xxxx") }
        let duplicateLabel = UILabel(frame: temp.frame )
        duplicateLabel.text = temp.text
        duplicateLabel.font = temp.font
        return duplicateLabel
    }
}
