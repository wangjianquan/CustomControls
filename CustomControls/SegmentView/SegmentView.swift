//
//  SegmentView.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/24.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class SegmentView: UIView {

      
      //标题数组
      var titles: [String]?
    
      //  未选中时的文字颜色,默认黑色
      var titleNormalColor: UIColor = UIColor.black {
            didSet{
                  
            }
      }
    
      // 选中时的文字颜色,默认红色
      var titleSelectColor: UIColor  = UIColor.red {
            didSet{
                  
            }
      }
      //字体大小，默认15
      var titleFont: UIFont? = UIFont.systemFont(ofSize: 15) {
            didSet{
                  
            }
      }
      
      //当前被选中的下标，设置默认选中下标为0
      var selectedIndex: Int = 0
      
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

}

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

extension SegmentView: UICollectionViewDelegate, UICollectionViewDataSource {
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.titles?.count ?? 0
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SegmentCollectionCell
            cell?.titleLabel.font = self.titleFont
            cell?.isSeleted = indexPath.row == selectedIndex ? true : false
            if let title = self.titles?[indexPath.row] {
                  cell?.titleLabel.text = title
            }
            return cell!
      }
      
      
}
