//
//  SegmentView.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class SegmentView: UIView {

      fileprivate let kUMMaxVisibleCount = 3
      
       var  titleSelectedBlock: ((_ selectedIndex: Int) -> Void)?
      /**
       *  标题数组
       */
      @IBInspectable
      var titles: [String]?
     
      /**
       *  字体大小，默认15
       */
      @IBInspectable
      var titleFont: UIFont?
      
      /**
       *  未选中时的文字颜色,默认黑色
       */
      @IBInspectable
      var titleNormalColor: UIColor = UIColor.darkText {
            didSet{
                  self.updateView()
            }
      }
      
      /**
       *  选中时的文字颜色,默认红色
       */
      @IBInspectable
      var titleSelectColor: UIColor  = UIColor(hex: 0x2196F3) {
            didSet{
                  self.updateView()
            }
      }
      
      /**
        * 下划线颜色  (设置 colorIsSame == false 时有效否则默认和选中颜色一致)
       */
      @IBInspectable
      var bottomLineColor: UIColor?
      
      /**
       * 文字选中颜色与下划线颜色是否一致(colorIsSame == false 时设置 bottomLineColor属性才有效)
       */
      
      var colorIsSame: Bool?
      
      /**
       *  下划线通过UIBezierPath创建, 起点: CGPoint(x: titleLabel.frame.minX + bottomLineX , y: y))
       终点: linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - bottomLineX, y: y))
       注意: 值越大线越短
       */
       var bottomLineX: CGFloat?
      
      /**
       *  下划线 : UIBezierPath().lineWidth = bottomLineHeight
          default value is 3
       */
      var bottomLineHeight: CGFloat?
     
      /**
       *  当前被选中的下标，设置默认选中下标为0
       */
      @IBInspectable
      var selectedIndex: Int = 0 {
            didSet {
                  self.collectionView.scrollToItem(at: IndexPath(row: selectedIndex, section: 0), at: .centeredHorizontally, animated: true)
                  self.updateView()
            }
      }
      
      fileprivate  lazy var collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize  = CGSize(width: 20, height: 20)
            layout.scrollDirection = .horizontal
            
            let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: SegmentViewFlowLayout())
            collection.delegate = self
            collection.dataSource = self
            collection.backgroundColor = UIColor.white
            collection.register(SegmentCollectionCell.self, forCellWithReuseIdentifier: "cell")
            return collection
      }()
      
      override init(frame: CGRect) {
            super.init(frame: frame)
            setUI()
      }
      required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setUI()
      }
    
      
      fileprivate func setUI() {
            self.titleFont = UIFont.systemFont(ofSize: 15)
            self.bottomLineX = 50
            self.bottomLineHeight = 3
            self.colorIsSame = true
            self.bottomLineColor =  UIColor(hex: 0x2196F3)
            self.backgroundColor = UIColor.clear
            self.collectionView.translatesAutoresizingMaskIntoConstraints = false
            
            let constraintW = NSLayoutConstraint(item: self.collectionView, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 1, constant: 0)
            let constraintH = NSLayoutConstraint(item: self.collectionView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 1, constant: 0)
            let constraintX = NSLayoutConstraint(item: self.collectionView, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
            let constraintY = NSLayoutConstraint(item: self.collectionView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
            self.addSubview(self.collectionView)
            self.addConstraints([constraintW,constraintH,constraintX,constraintY])
      }
      
      func selectedIndex(index:NSInteger)  {
            guard let item = self.titles?.count else {
                  return
            }
            if index < 0 || index >= item  {
                  return
            }
            self.selectedIndex = index
      }

      fileprivate func updateView() {
            self.collectionView.reloadData()
      }
      
}


// MARK: - UICollectionViewDataSource
extension SegmentView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.titles?.count ?? 0
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SegmentCollectionCell
            cell?.titleLabel.font = self.titleFont
            cell?.bottomLineX = self.bottomLineX
            cell?.bottomLineHeight = self.bottomLineHeight
            cell?.isSeleted = indexPath.row == selectedIndex ? true : false
            cell?.titleLabel.textColor = cell?.isSeleted == true ? self.titleSelectColor : self.titleNormalColor
            cell?.bottomLineColor = self.colorIsSame == true ? cell?.titleLabel.textColor : self.bottomLineColor
            if let title = self.titles?[indexPath.row] {
                  cell?.titleLabel.text = title
            }
            return cell!
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let viewSize = self.bounds.size
            return CGSize(width: viewSize.width / CGFloat(kUMMaxVisibleCount), height: viewSize.height)
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            self.selectedIndex = indexPath.row
            collectionView.reloadData()
            if titleSelectedBlock != nil {
                  titleSelectedBlock!(indexPath.row)
            }
           
      }

}
// MARK: - 自定义 layout
class SegmentViewFlowLayout: UICollectionViewFlowLayout {
      override func prepare() {
            super.prepare()
            itemSize = CGSize(width: 23, height: 23)
            minimumLineSpacing = 0
            minimumInteritemSpacing = 0
            scrollDirection = .horizontal
            collectionView?.showsVerticalScrollIndicator = false
            collectionView?.showsHorizontalScrollIndicator = false
      }
}
