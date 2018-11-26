//
//  ContentScrollView.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/26.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit



class ContentScrollView: UIView {
      
       var  toIndexBlock: ((_ index: NSInteger) -> Void)?

      var viewControllers : [UIViewController] = []
      
     fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = self.frame.size
            layout.minimumLineSpacing  = 0.1
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0.1, bottom: 0, right: 0.1)
            return layout
      }()
      
      fileprivate lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
            collection.isScrollEnabled = true
            collection.isPagingEnabled = true
            collection.delaysContentTouches = false
            collection.showsVerticalScrollIndicator = false
            collection.showsHorizontalScrollIndicator = false
            collection.backgroundColor = UIColor.white
            collection.delegate = self
            collection.dataSource = self
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")

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
      
      fileprivate func setUI()  {
            self.collectionView.frame = self.bounds
            self.addSubview(self.collectionView)
            
      }
   
      func selectIndex(index: NSInteger)  {
            if index < 0 || index >= self.viewControllers.count {
                  return
            }
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: [.centeredVertically, .centeredHorizontally], animated: false)
      }
      
      func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let index = scrollView.contentOffset.x / self.frame.size.width
            if  toIndexBlock != nil {
                toIndexBlock!(Int(index))
            }
      }

}


extension ContentScrollView : UICollectionViewDelegate, UICollectionViewDataSource {
      func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
      }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return self.viewControllers.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            let vc : UIViewController = self.viewControllers[indexPath.row]
            vc.view.frame = cell.bounds
            cell.contentView.addSubview(vc.view)
            return cell
      }
      
      
}
