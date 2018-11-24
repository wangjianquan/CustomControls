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
      
 
     fileprivate let textColor: UIColor = UIColor(hex: 0x2196F3)
           
      
      /**
       *  选中后下划线高度
       */
      var bottomLineWidth : CGFloat!
 
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
            self.bottomLineWidth = 3.0
            self.addSubview(self.titleLabel)
      }
      
      
      override func draw(_ rect: CGRect) {
            if isSeleted == true {
                  let linePath = UIBezierPath()
                  let y: CGFloat = rect.height - bottomLineWidth
                  linePath.move(to: CGPoint(x: titleLabel.frame.minX + 4, y: y))
                  linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - 4, y: y))
                  linePath.lineWidth = bottomLineWidth
                  textColor.setStroke()
                  linePath.stroke()
            }
      }
      
}
