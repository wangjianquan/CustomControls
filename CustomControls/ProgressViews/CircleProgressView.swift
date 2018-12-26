//
//  CircleProgressView.swift
//  FaXinSwift
//
//  Created by landixing on 2018/8/27.
//  Copyright © 2018年 WJQ. All rights reserved.
//2

import UIKit

class CircleProgressView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    //MARK: --
    @IBInspectable var progress : CGFloat = 0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // MARK: - 圆圈背景颜色
    @IBInspectable var circleColor: UIColor?
    // MARK: - 圆弧背景颜色
    @IBInspectable var arcColor: UIColor?
  
    // MARK: - title文字颜色
    @IBInspectable var titleColor: UIColor?
    // MARK: - subTitle文字颜色
    @IBInspectable var subTitleColor: UIColor?
    
    // MARK: - title 文字
    @IBInspectable var title: String?
    // MARK: - subTitle 文字
    @IBInspectable var subTitle: String?
    // MARK: - 背景圆圈 宽度
    var circleLineWidth: CGFloat?
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        let  maxWidth = self.frame.size.width < self.frame.size.height ? self.frame.size.width : self.frame.size.height

        let center = CGPoint(x: maxWidth * 0.5, y: maxWidth * 0.5)
        let radius = rect.width * 0.5 - 8
        let startAngle = CGFloat(-Double.pi/2)
        let endAngle = CGFloat(Double.pi * 2) * progress + startAngle
        
        
        let basePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: CGFloat(Double.pi * 2) + startAngle, clockwise: true)
        basePath.lineWidth = circleLineWidth!
        circleColor?.setStroke()
        basePath.stroke()
        
        
        let closePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        closePath.lineWidth = circleLineWidth!
        arcColor?.setStroke()
        closePath.lineCapStyle = .round //线条拐角
        closePath.lineJoinStyle = .round //终点处理
        closePath.stroke()
        setUpTitle()
    }
    
    fileprivate func setUp() {
        self.backgroundColor = UIColor.clear
        circleColor = UIColor.orange
        arcColor = UIColor.white
        titleColor = UIColor.white
        subTitleColor = UIColor.white
        title = " "
        subTitle = " "
        circleLineWidth = 10
    }
    
    fileprivate func setUpTitle() {
        let title = self.title
        
       
        //段落格式
        let textStyle = NSMutableParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        textStyle?.lineBreakMode = .byWordWrapping
        textStyle?.alignment = .center //水平居中
        
        //构建属性集合
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedString.Key.paragraphStyle: textStyle!, NSAttributedString.Key.foregroundColor: titleColor!] as [NSAttributedString.Key : Any]
        
        
        //获得size
        let stringSize: CGSize = title!.size(withAttributes: attributes)
        //垂直居中
        let r = CGRect(x: (self.frame.size.width - stringSize.width) / 2.0, y: (self.frame.size.height - stringSize.height - 20) / 2.0, width: stringSize.width, height: stringSize.height)
        title?.draw(in: r, withAttributes: attributes)

        
        
        /*
          **子标题
         */
        let subtitle = self.subTitle
        
        let subTextStyle = NSMutableParagraphStyle.default.mutableCopy() as? NSMutableParagraphStyle
        subTextStyle?.lineBreakMode = .byWordWrapping
        subTextStyle?.alignment = .center
        
        //构建属性集合
        let subAttributes = [NSAttributedString.Key.font:UIFont.boldSystemFont(ofSize: 16),NSAttributedString.Key.paragraphStyle:subTextStyle!, NSAttributedString.Key.foregroundColor:subTitleColor!] as [NSAttributedString.Key : Any]
        
        let subStrSize : CGSize = subtitle!.size(withAttributes: subAttributes)
        
        //垂直居中
        let subR = CGRect(x: (self.frame.size.width - subStrSize.width) / 2.0, y: r.origin.y + stringSize.height + 8, width: subStrSize.width, height: subStrSize.height)
        subtitle?.draw(in: subR, withAttributes: subAttributes)
        
        
    }
    

}
