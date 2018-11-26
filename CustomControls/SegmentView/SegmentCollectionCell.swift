//
//  SegmentCollectionCell.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class SegmentCollectionCell: UICollectionViewCell {
    
       //  标签label
      lazy var titleLabel: UILabel = {
            let label = UILabel.init()
            label.textAlignment = .center
            label.textColor = UIColor.blue
            label.font = UIFont.systemFont(ofSize: 15)
            return label
      }()
      
      //  当前是否被选中
      var isSeleted: Bool = true {
            didSet{
                  self.titleLabel.textColor = isSeleted == true ? UIColor(hex: 0x2196F3) : UIColor.lightGray
                  self.setNeedsDisplay()
            }
      }
      
 
    
      /**
       * bottomLineColor
       */
      var bottomLineColor: UIColor!
      
      /**
       *  下划线高度
       */
      var bottomLineHeight : CGFloat!
      
      /**
       *  下划线起点
       */
      var bottomLineX: CGFloat!
    
      override init(frame: CGRect) {
            super.init(frame: frame)
            self.setUI()
      }
      
      required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            self.setUI()
      }
      
      fileprivate func setUI() {
            self.backgroundColor = UIColor.clear
            self.titleLabel.frame =  CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
            self.addSubview(self.titleLabel)
      }
      
      
      override func draw(_ rect: CGRect) {
            if isSeleted == true {
                  let linePath = UIBezierPath()
                  let y: CGFloat = rect.height - self.bottomLineHeight
                  //起点
                  linePath.move(to: CGPoint(x: titleLabel.frame.minX + self.bottomLineX , y: y))
                  //终点
                  linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - self.bottomLineX, y: y))
                  linePath.lineWidth = self.bottomLineHeight
                  bottomLineColor.setStroke()
                  linePath.stroke()
            }
      }
      
}
