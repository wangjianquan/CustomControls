//
//  ShareViewController.swift
//  QKaProject
//
//  Created by 白小嘿 on 2018/11/29.
//  Copyright © 2018 simpleWQZ. All rights reserved.
//

import UIKit

class ShareViewController: UIViewController {

      let view_height = 230
      var shareBlock: ((_ index: Int) -> Void)?
      
      lazy var cancelBtn: UIButton = {
            let btn = UIButton(frame: CGRect.zero)
            btn.setTitle("取消", for: .normal)
            btn.setTitleColor(UIColor.darkGray, for: .normal)
            btn.setTitleColor(UIColor.lightGray, for: .highlighted)
            btn.backgroundColor = UIColor.groupTableViewBackground
//            btn.safeAreaLayoutGuide.bottomAnchor =
//            btn.safeAreaLayoutGuide
            btn.addTarget(self, action: #selector(ShareViewController.cancelButtonAction(_:)), for: .touchUpInside)
            return btn
      }()
      
      let itemWidth = (UIScreen.main.bounds.size.width - 20) / 4
      
      fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: itemWidth, height: 230-30)
            layout.minimumLineSpacing  = 0
            layout.minimumInteritemSpacing = 0
            layout.scrollDirection = .horizontal
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0.1, bottom: 0, right: 0.1)
            return layout
      }()
      
      fileprivate lazy var collectionView: UICollectionView = {
            let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
           
            collection.showsVerticalScrollIndicator = false
            collection.showsHorizontalScrollIndicator = false
            collection.backgroundColor = UIColor.yellow
            collection.delegate = self
            collection.dataSource = self
            collection.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
            collection.bounces = true
            collection.register(ShareCollectionCell.self, forCellWithReuseIdentifier: "shareCell")
            return collection
      }()
      lazy var titles: [String] = ["微信好友", "朋友圈", "分享链接", "分享好友"]
      lazy var images: [String] = ["xdy_share_chat","xdy_share_timeline","xdy_share_link","xdy_share_group"]
    

      override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        setUI()
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
      
      
        // Do any additional setup after loading the view.
     }
    
     fileprivate func setUI()  {
//            self.collectionView.frame  = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 230 - 30)
//            self.cancelBtn.frame = CGRect(origin: CGPoint(x: 0, y: self.collectionView.frame.maxY), size: CGSize(width: self.view.frame.size.width, height: 30))
      
      self.collectionView.translatesAutoresizingMaskIntoConstraints = false
      self.cancelBtn.translatesAutoresizingMaskIntoConstraints  = false
      view.addSubview(self.cancelBtn)
      view.addSubview(self.collectionView)
      let btnleft = NSLayoutConstraint(item: cancelBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
       let btnRight = NSLayoutConstraint(item: cancelBtn, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
      let btnHeight = NSLayoutConstraint.init(item: cancelBtn, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 44)
      var btnbottom = NSLayoutConstraint()
      if #available(iOS 11.0, *) {
          btnbottom =   NSLayoutConstraint.init(item: self.cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
      } else {
            // Fallback on earlier versions
          btnbottom =  NSLayoutConstraint.init(item: self.cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
      }
      self.view.addConstraints([btnleft,btnRight,btnHeight,btnbottom])
      
      let collectionTop = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
      let collectionLeft = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
      let collectionRight = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
      let collectionBottom = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.cancelBtn, attribute: .top, multiplier: 1, constant: 0)
      
      
      self.view.addConstraints([collectionTop,collectionLeft,collectionRight,collectionBottom])
      // 使用NSLayoutConstraint-SSLayout
    
            view.addSubview(self.collectionView)
      }
      
      override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            super.willTransition(to: newCollection, with: coordinator)
            
      }
      
      func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
            self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? 230 : 230);
      }
      
    

}

// MARK: - 事件处理
extension ShareViewController: UICollectionViewDelegate, UICollectionViewDataSource {
      func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
      }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return titles.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shareCell", for: indexPath) as! ShareCollectionCell
            cell.imageName = images[indexPath.row]
            cell.title = titles[indexPath.row]
            return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            if shareBlock != nil {
                  shareBlock!(indexPath.row)
            }
      }
      
     
}
class ShareCollectionCell: UICollectionViewCell {

      var imageName: String? {
            didSet{
                  icon.image =  UIImage(named: imageName ?? "")
            }
      }
      var title: String? {
            didSet{
                  label.text = title
            }
      }
      
      fileprivate lazy var icon = UIImageView()
      fileprivate lazy var label = UILabel()
      override init(frame: CGRect) {
            super.init(frame: frame)
             setUI()
      }
      required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
             setUI()
      }
      
      fileprivate func setUI()  {
            icon.frame = CGRect(x: 15, y: 15, width: self.contentView.frame.size.width - 30, height: self.contentView.frame.size.width - 30)
            icon.contentMode = .scaleToFill
            label.frame = CGRect(x: 5, y: icon.frame.maxY+5, width: self.contentView.frame.size.width - 10, height: 21)
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 15)
            label.adjustsFontSizeToFitWidth = true
            addSubview(icon)
            addSubview(label)
      }
      
      
}

// MARK: - 事件处理
extension ShareViewController {
      @objc fileprivate func cancelButtonAction(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
      }
}
