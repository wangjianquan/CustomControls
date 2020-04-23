//
//  ShareViewController.swift
//  QKaProject
//
//  Created by 白小嘿 on 2018/11/29.
//  Copyright © 2018 simpleWQZ. All rights reserved.
//

import UIKit

struct Share {
    let title : String
    let imageName : String
}

class ShareViewController: UIViewController {



    var shareBlock: ((_ selectedIndex: Share) -> Void)?


    fileprivate let view_height = SCREEN_HEIGHT/5
    fileprivate let CancelBtnHieght: CGFloat = 30 + safeBottomHeight
    lazy var cancelBtn: UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.setTitle("取消", for: .normal)
        if iPhone_X {
            btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        }
        btn.setTitleColor(UIColor.darkGray, for: .normal)
        btn.setTitleColor(UIColor.lightGray, for: .highlighted)
        btn.backgroundColor = UIColor.white
    //            btn.safeAreaLayoutGuide.bottomAnchor =
    //            btn.safeAreaLayoutGuide
        btn.addTarget(self, action: #selector(ShareViewController.cancelButtonAction(_:)), for: .touchUpInside)
        return btn
    }()

    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = self.view.frame.size.width / 4
        layout.itemSize = CGSize(width: itemWidth, height: view_height-CancelBtnHieght)
        layout.minimumLineSpacing  = 1
        layout.minimumInteritemSpacing = 1
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }()

    fileprivate lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.backgroundColor = .groupTableViewBackground
        collection.delegate = self
        collection.dataSource = self
        collection.bounces = true
        collection.register(ShareCollectionCell.self, forCellWithReuseIdentifier: ShareCollectionCell.reuse_identifier)
        return collection
    }()
    
    
    lazy var dataSource: [Share] = {
        var array = [Share]()
        let chat = Share(title: "微信好友", imageName: "xdy_share_chat")
        let line = Share(title: "朋友圈", imageName: "xdy_share_timeline")
        let link = Share(title: "分享链接", imageName: "xdy_share_link")
        let group = Share(title: "分享好友", imageName: "xdy_share_group")
        array.append(chat)
        array.append(line)
        array.append(link)
        array.append(group)
        return array
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .groupTableViewBackground
        setUI()
        updatePreferredContentSizeWithTraitCollection(traitCollection: self.traitCollection)
    // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    fileprivate func setUI()  {
        self.collectionView.frame  = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: view_height - CancelBtnHieght)
        self.cancelBtn.frame = CGRect(origin: CGPoint(x: 0, y: self.collectionView.frame.maxY+1), size: CGSize(width: self.view.frame.size.width, height: CancelBtnHieght))

        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.cancelBtn.translatesAutoresizingMaskIntoConstraints  = false
        view.addSubview(self.cancelBtn)
        view.addSubview(self.collectionView)
        //      let btnleft = NSLayoutConstraint(item: cancelBtn, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 0)
        //       let btnRight = NSLayoutConstraint(item: cancelBtn, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: 0)
        //      let btnHeight = NSLayoutConstraint.init(item: cancelBtn, attribute: .height, relatedBy: .equal, toItem: self.view, attribute: .height, multiplier: 1, constant: 44)
        //      var btnbottom = NSLayoutConstraint()
        //      if #available(iOS 11.0, *) {
        //          btnbottom =   NSLayoutConstraint.init(item: self.cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1.0, constant: 0)
        //      } else {
        //            // Fallback on earlier versions
        //          btnbottom =  NSLayoutConstraint.init(item: self.cancelBtn, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0)
        //      }
        //      self.view.addConstraints([btnleft,btnRight,btnHeight,btnbottom])
        //
        //      let collectionTop = NSLayoutConstraint(item: collectionView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 0)
        //      let collectionLeft = NSLayoutConstraint(item: collectionView, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0)
        //      let collectionRight = NSLayoutConstraint(item: collectionView, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1, constant: 0)
        //      let collectionBottom = NSLayoutConstraint(item: collectionView, attribute: .bottom, relatedBy: .equal, toItem: self.cancelBtn, attribute: .top, multiplier: 1, constant: 0)
        //
        //
        //      self.view.addConstraints([collectionTop,collectionLeft,collectionRight,collectionBottom])
        //      // 使用NSLayoutConstraint-SSLayout
        //
        //            view.addSubview(self.collectionView)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        super.willTransition(to: newCollection, with: coordinator)
    }

    func updatePreferredContentSizeWithTraitCollection(traitCollection: UITraitCollection) {
        self.preferredContentSize = CGSize(width: self.view.bounds.size.width, height: traitCollection.verticalSizeClass == UIUserInterfaceSizeClass.compact ? view_height : view_height);
    }



}

// MARK: - 事件处理
extension ShareViewController: UICollectionViewDelegate, UICollectionViewDataSource {
      func numberOfSections(in collectionView: UICollectionView) -> Int {
            return 1
      }
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ShareCollectionCell.reuse_identifier, for: indexPath) as! ShareCollectionCell
            cell.share = dataSource[indexPath.row]
            return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            collectionView.deselectItem(at: indexPath, animated: true)
            if shareBlock != nil {
                shareBlock!(dataSource[indexPath.row])
                self.dismiss(animated: true, completion: nil)
            }
      }
}

class ShareCollectionCell: UICollectionViewCell {

    var share : Share? {
        didSet{
            guard let model = share else { return }
            icon.image =  UIImage(named: model.imageName)
            label.text = model.title
        }
    }

    
    fileprivate lazy var icon: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    fileprivate lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUI()
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentSize = self.contentView.frame.size
        let icon_x: CGFloat = 30
        let icon_y: CGFloat = 25
        let iconWH: CGFloat = contentSize.width - 2*icon_x
        icon.frame = CGRect(x: icon_x, y: icon_y, width: iconWH, height:iconWH)
        label.frame = CGRect(x: 5, y: icon.frame.maxY+10, width: contentSize.width - 10, height: 21)
    }

    fileprivate func setUI()  {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(icon)
        self.contentView.addSubview(label)
    }
      
      
}

// MARK: - 事件处理
extension ShareViewController {
      @objc fileprivate func cancelButtonAction(_ sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
      }
}
