//
//  SegmentView.swift
//  CustomControls
//
//  Created by 白小嘿 on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit
import SnapKit

struct SegmentViewModel {
    var title: String?
    var textWidth: CGFloat = 0

}

class SegmentView: UIView {
    
    fileprivate let kUMMaxVisibleCount = 3
    fileprivate var totalTextWidth: CGFloat = 0

    var  titleSelectedBlock: ((_ selectedIndex: Int) -> Void)?
    
    /**
     *  标题数组
     */
    fileprivate var _titles: [String] = Array()
    @IBInspectable
    var titles: [String] {
        get {
            return _titles
        }
        set {
            _titles = newValue
            if _titles.count > 0 {
                for string in _titles {
                    var model = SegmentViewModel()
                    model.title = string
                    model.textWidth = widthForTitle(string)
                    self.totalTextWidth += model.textWidth
                    self.dataSource.append(model)
                }
                Dlog(self.totalTextWidth)
                updateView()
            }
        }
    }
    
    
    fileprivate lazy var dataSource: [SegmentViewModel] = Array()
    
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
     * 下划线颜色  (设置 colorIsSame == false 时有效，否则默认和选中颜色一致)
     */
    @IBInspectable
    var bottomLineColor: UIColor?

    /**
     * 文字选中颜色与下划线颜色是否一致(colorIsSame == false 时设置 bottomLineColor属性才有效)
     */
    var colorIsSame: Bool?
    
    /**
     *  下划线通过UIBezierPath创建, 起点: CGPoint(x: titleLabel.frame.minX + bottomLineX , y: y))
     *  终点: linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - bottomLineX, y: y))
     *  注意: 值越大线越短
     */
    var bottomLineX: CGFloat?
    
    /**
     * 下划线通过UIBezierPath创建,
     * 下划线起点：左对齐
     */
    var bottomLineLeading: Bool!
    
    /**
     * 下划线 : UIBezierPath().lineWidth = bottomLineHeight
     * default value is 3
     */
    var bottomLineHeight: CGFloat?
    

    /**
     * 当前被选中的下标，设置默认选中下标为0
     */
//    @IBInspectable
    var selectedIndex: Int? = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
                self.collectionView.scrollToItem(at: IndexPath(item: self.selectedIndex!, section: 0), at: .centeredHorizontally, animated: true)
            }
            self.updateView()
        }
    }
    
    fileprivate  lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: SegmentViewFlowLayout())
        collection.delegate = self
        collection.dataSource = self
        collection.backgroundColor = UIColor.white
        collection.register(SegmentCollectionCell.self, forCellWithReuseIdentifier: SegmentCollectionCell.reuse_identifier)
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
        self.backgroundColor = UIColor.clear
        
        self.titleFont = UIFont.systemFont(ofSize: 13)
        self.selectedIndex = 0
        self.bottomLineX = 50
        self.bottomLineLeading = true
        self.bottomLineHeight = 3
        self.colorIsSame = true
        self.bottomLineColor =  self.titleSelectColor
        self.collectionView.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
        self.addSubview(self.collectionView)
        
    }
      
    func selectedIndex(index:NSInteger)  {
        let item = self.titles.count
        if index < 0 || index >= item  {
            return
        }
        self.selectedIndex = index
    }
    
    fileprivate func widthForTitle(_ title: String) -> CGFloat {
        let textWidth = NSString(string: title).boundingRect(with: CGSize(width: CGFloat.infinity, height: CGFloat.infinity), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font : self.titleFont!], context: nil).size.width
        return CGFloat(ceilf(Float(textWidth)))
    }
    
    fileprivate func updateView() {
        self.collectionView.reloadData()
    }
      
}

// MARK: - 自定义 layout
fileprivate class SegmentViewFlowLayout: UICollectionViewFlowLayout {
    override func prepare() {
        super.prepare()
        itemSize = CGSize(width: 23, height: 23)
        minimumLineSpacing = 0
        minimumInteritemSpacing = 10
        scrollDirection = .horizontal
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView?.showsVerticalScrollIndicator = false
        collectionView?.showsHorizontalScrollIndicator = false
      }
}

fileprivate class SegmentCollectionCell: UICollectionViewCell {
    
    var model : SegmentViewModel? {
        didSet{
            if let model = model {
                self.titleLabel.text = model.title
            }
        }
    }
    
    /**
     * 标题
     */
    fileprivate lazy var titleLabel: UILabel = {
        let label = UILabel.init()
        label.textAlignment = .center
        label.textColor = UIColor.blue
        return label
    }()

    var titleFont: UIFont? {
        didSet{
            guard let font = titleFont else { return }
            self.titleLabel.font = font
        }
    }

    /**
    * 当前是否被选中
    */
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
     * 下划线通过UIBezierPath创建,
     * 下划线起点：左对齐
     */
    var bottomLineLeading: Bool!
    
    /**
     *  下划线通过UIBezierPath创建, 起点: CGPoint(x: titleLabel.frame.minX + bottomLineX , y: y))
     *  终点: linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - bottomLineX, y: y))
     *  注意: 值越大线越短
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
        self.backgroundColor = UIColor.white
        self.addSubview(self.titleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let labelSize = titleLabel.sizeThatFits(self.contentView.bounds.size)
        let labelBounds = CGRect(x: 0, y: 0, width: labelSize.width, height: labelSize.height)
        titleLabel.bounds = labelBounds
        titleLabel.center = contentView.center
    }
    
    override func draw(_ rect: CGRect) {
        if isSeleted == true {
            let linePath = UIBezierPath()
            let y: CGFloat = rect.height - self.bottomLineHeight
            let contentWidth =  CGFloat(ceilf(Float(rect.width)))
            let textWidth: CGFloat = self.model?.textWidth ?? 0

            let startX: CGFloat = CGFloat(ceilf(Float(contentWidth - textWidth))) / 2

//            //起点
//            linePath.move(to: CGPoint(x: titleLabel.frame.minX + self.bottomLineX , y: y))
//            //终点
//            linePath.addLine(to: CGPoint(x: titleLabel.frame.maxX - self.bottomLineX, y: y))
            
            if self.bottomLineLeading == true {
                //起点
                linePath.move(to: CGPoint(x: startX , y: y))
                //终点
                linePath.addLine(to: CGPoint(x: startX + textWidth, y: y))
            }else{
                linePath.move(to: CGPoint(x: (contentWidth)/3 , y: y))
                //终点
                linePath.addLine(to: CGPoint(x: (contentWidth)/3*2, y: y))
            }
            
            linePath.lineWidth = self.bottomLineHeight
            linePath.lineCapStyle = .round
            bottomLineColor.setStroke()
            linePath.stroke()
        }
    }
      
     
}

// MARK: - UICollectionViewDelegate
extension SegmentView: UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
}

// MARK: - UICollectionViewDataSource
extension SegmentView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionCell.reuse_identifier, for: indexPath) as? SegmentCollectionCell
        cell?.titleFont = self.titleFont
        cell?.bottomLineX = self.bottomLineX
        cell?.bottomLineLeading = self.bottomLineLeading
        cell?.bottomLineHeight = self.bottomLineHeight
        cell?.isSeleted = indexPath.row == selectedIndex ? true : false
        cell?.titleLabel.textColor = cell?.isSeleted == true ? self.titleSelectColor : self.titleNormalColor
        cell?.bottomLineColor = self.colorIsSame == true ? cell?.titleLabel.textColor : self.bottomLineColor
        
        let model = self.dataSource[indexPath.row]
        cell?.model = model
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let viewSize = collectionView.frame.size
        let model = self.dataSource[indexPath.row]
        if self.totalTextWidth < viewSize.width {
            return CGSize(width: viewSize.width/CGFloat(self.titles.count) , height: viewSize.height)
        }else{
            return CGSize(width: model.textWidth , height: viewSize.height)

        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        self.selectedIndex = indexPath.row
        if titleSelectedBlock != nil {
            titleSelectedBlock!(indexPath.row)
        }
    }
}


// MARK: - UICollectionViewDelegateFlowLayout
extension SegmentView: UICollectionViewDelegateFlowLayout {
   
    

}

