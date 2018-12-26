//
//  UIButton+badge.swift
//  CustomControls
//
//  Created by aixuexue on 2018/12/26.
//  Copyright © 2018 WJQ. All rights reserved.
//
import UIKit
import Foundation

var UIButton_badgeKey = "UIButton_badgeKey"
var UIButton_badgeBGColorKey = "UIButton_badgeBGColorKey"
var UIButton_badgeTextColorKey = "UIButton_badgeTextColorKey"
var UIButton_badgeFontKey = "UIButton_badgeFontKey"
var UIButton_badgePaddingKey = "UIButton_badgePaddingKey"
var UIButton_badgeMinSizeKey = "UIButton_badgeMinSizeKey"
var UIButton_badgeOriginXKey = "UIButton_badgeOriginXKey"
var UIButton_badgeOriginYKey = "UIButton_badgeOriginYKey"
var UIButton_shouldHideBadgeAtZeroKey = "UIButton_shouldHideBadgeAtZeroKey"
var UIButton_shouldAnimateBadgeKey = "UIButton_shouldAnimateBadgeKey"
var UIButton_badgeValueKey = "UIButton_badgeValueKey"

extension UIButton {

    // MARK: - get {} , set { }
    var badge: UILabel {
        get {
            let label = objc_getAssociatedObject(self, &UIButton_badgeKey) as? UILabel
            if let lab = label {
                return lab
            }
            return UILabel()
        }
        set {
            objc_setAssociatedObject(self, &UIButton_badgeKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }

    var badgeValue : String  {
        get{
            return objc_getAssociatedObject(self, &UIButton_badgeValueKey) as! String
        }

        set {
                objc_setAssociatedObject(self, &UIButton_badgeValueKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)

                // When changing the badge value check if we need to remove the badge
                if badgeValue.isEmpty  || (badgeValue == "") || ((badgeValue == "0") && shouldHideBadgeAtZero) {
                    removeBadge()
                } else if (self.badge == nil ) {

                    // Create a new badge because not existing
                   self.badge  = UILabel(frame: CGRect(x: self.badgeOriginX, y: self.badgeOriginY, width: 20, height: 20))
                    self.badge.textColor = self.badgeTextColor
                    self.badge.backgroundColor = self.badgeBGColor
                    self.badge.font = self.badgeFont
                    self.badge.textAlignment = .right
                    badgeInit()
                    addSubview(self.badge)
                    updateBadgeValue(animated: false)
                } else {
                    updateBadgeValue(animated: true)
                }
        }

    }



    // Badge background color
    var badgeBGColor: UIColor? {
        get {
            return objc_getAssociatedObject(self, &UIButton_badgeBGColorKey) as? UIColor
        }
        set {
            objc_setAssociatedObject(self, &UIButton_badgeBGColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                refreshBadge()
            }
        }
    }
    // Badge text color
    var badgeTextColor: UIColor? {
        get{
            return objc_getAssociatedObject(self, &UIButton_badgeTextColorKey) as? UIColor
        }
        set{
            objc_setAssociatedObject(self, &UIButton_badgeTextColorKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                refreshBadge()
            }
        }
    }


    // Badge font
    var badgeFont: UIFont? {
        get {
            return objc_getAssociatedObject(self, &UIButton_badgeFontKey) as? UIFont
        }
        set{
            objc_setAssociatedObject(self, &UIButton_badgeFontKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                refreshBadge()
            }
        }
    }
    // Padding value for the badge
    var badgePadding: CGFloat {
        get{
            let number  = objc_getAssociatedObject(self, &UIButton_badgePaddingKey) as? CGFloat
            return number ?? 0
        }
        set{
            let number = Double(newValue)
            objc_setAssociatedObject(self, &UIButton_badgePaddingKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                updateBadgeFrame()
            }

        }
    }
    // Minimum size badge to small
    var badgeMinSize: CGFloat {
        get{
            let number = objc_getAssociatedObject(self, &UIButton_badgeMinSizeKey) as? CGFloat
            return number ?? 0
        }
        set{
            let number = Double(newValue)
            objc_setAssociatedObject(self, &UIButton_badgeMinSizeKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                updateBadgeFrame()
            }
        }
    }

    var badgeOriginX: CGFloat {
        get{
            let number = objc_getAssociatedObject(self, &UIButton_badgeOriginXKey) as? NSNumber
            return CGFloat(number?.floatValue ?? 10)
        }
        set{
            let number = Double(newValue)
            objc_setAssociatedObject(self, &UIButton_badgeOriginXKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (badge != nil) {
                updateBadgeFrame()
            }
        }
    }

    var badgeOriginY: CGFloat {
        get{
            let number = objc_getAssociatedObject(self, &UIButton_badgeOriginYKey) as? NSNumber
            return CGFloat(number?.floatValue ?? 10)
        }
        set{
            let number = Double(newValue)
            objc_setAssociatedObject(self, &UIButton_badgeOriginYKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if (self.badge != nil) {
                updateBadgeFrame()
            }
        }
    }

    // In case of numbers, remove the badge when reaching zero
    var shouldHideBadgeAtZero: Bool {
        get {
            let number = objc_getAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey) as? NSNumber
            return number?.boolValue ?? false
        }
        set {
            let number = NSNumber(booleanLiteral: newValue)
            objc_setAssociatedObject(self, &UIButton_shouldHideBadgeAtZeroKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    // Badge has a bounce animation when value changes
    var shouldAnimateBadge: Bool {
        get{
            let number = objc_getAssociatedObject(self, &UIButton_shouldAnimateBadgeKey) as? NSNumber
            return number?.boolValue ?? false
        }
        set{
            let number = NSNumber(booleanLiteral: newValue)
            objc_setAssociatedObject(self, &UIButton_shouldAnimateBadgeKey, number, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }




    /*
      **
     */




    func badgeInit()  {
        self.badgeBGColor   = .red
        self.badgeTextColor = .white
        self.badgeFont      = UIFont.systemFont(ofSize: 12.0)
        self.badgePadding   = 6
        self.badgeMinSize   = 8
//        if let label = self.badge {
            self.badgeOriginX   = self.frame.size.width - self.badge.frame.size.width/2
//        }
        self.badgeOriginY   = -4
        self.shouldHideBadgeAtZero = true
        self.shouldAnimateBadge = true
        self.clipsToBounds = false
    }

    func refreshBadge() {
        self.badge.textColor = self.badgeTextColor
        self.badge.backgroundColor  = self.badgeBGColor
        self.badge.font  = self.badgeFont
    }

    func removeBadge() {
        // Animate badge removal
        UIView.animate(withDuration: 0.2, animations: {
            self.badge.transform = CGAffineTransform.init(scaleX: 0, y: 0)
        }) { (finished: Bool) in
            self.badge.removeFromSuperview()
            self.badge == nil
        }
    }



    func updateBadgeValue(animated: Bool) {
        if animated && self.shouldAnimateBadge && !(self.badge.text == self.badgeValue) {
            let animation = CABasicAnimation(keyPath: "transform.scale")
            animation.fromValue = 1.5
            animation.toValue = 1
            animation.duration = 0.2
            animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.4, 1.3, 1.0, 1.0)
           self.badge.layer.add(animation, forKey: "bounceAnimation")
        }
        self.badge.text = self.badgeValue
        let duration: TimeInterval = (animated && self.shouldAnimateBadge) ? 0.2 : 0
        UIView.animate(withDuration: duration, animations: {
            self.updateBadgeFrame()
        })
    }

    func updateBadgeFrame() {
        let expectedLabelSize: CGSize = badgeExpectedSize()
        var minHeight: CGFloat = expectedLabelSize.height
        minHeight = (minHeight < badgeMinSize) ? badgeMinSize : expectedLabelSize.height
        var minWidth: CGFloat = expectedLabelSize.width
        let padding = self.badgePadding
        minWidth = (minWidth < minHeight) ? minHeight : expectedLabelSize.width
        self.badge.frame = CGRect(x: self.badgeOriginX, y: self.badgeOriginY, width: minWidth + padding, height: minHeight + padding)
        self.badge.layer.cornerRadius = (minHeight + padding) / 2
        self.badge.layer.masksToBounds = true
    }

    func badgeExpectedSize() -> CGSize {

        let frameLabel: UILabel = duplicate(self.badge)
        frameLabel.sizeToFit()
        let expectedLabelSize: CGSize? = frameLabel.frame.size
        return expectedLabelSize ?? CGSize.zero
    }

    func duplicate(_ labelToCopy: UILabel ) -> UILabel {
        let duplicateLabel = UILabel(frame: labelToCopy.frame )
        duplicateLabel.text = labelToCopy.text
        duplicateLabel.font = labelToCopy.font
        return duplicateLabel
    }


}



extension CALayer {
    private struct AssociatedKeys {
        static var shapeLayer:CAShapeLayer?
    }

    var shapeLayer: CAShapeLayer? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.shapeLayer) as? CAShapeLayer
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.shapeLayer, newValue as CAShapeLayer?, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}
