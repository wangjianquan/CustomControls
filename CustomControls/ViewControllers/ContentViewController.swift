//
//  ContentViewController.swift
//  CustomControls
//
//  Created by 白小嘿 on 2018/11/26.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {
        
       

    lazy var segmentView: SegmentView = {
        let segmentView = SegmentView(frame:  CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        segmentView.titles = ["基本的","案件信息","记录"]
        segmentView.titleSelectedBlock = { [unowned self] (index) in
                  Dlog("\(index)")
            self.contentScrollView.selectIndex(index: index)
        }
        return segmentView
        }()

    lazy var contentScrollView: ContentScrollView = {
        let contentView = ContentScrollView(frame: CGRect(x: 0, y: self.segmentView.frame.maxY, width: self.view.bounds.width, height: self.view.bounds.height - self.segmentView.frame.maxY))
        contentView.toIndexBlock = {[weak self ] index in
        self?.segmentView.selectedIndex(index: index)
        }
        contentView.viewControllers = addChildsVC()
        return contentView
        }()
    func addChildsVC() -> [UIViewController] {
        let first = FirstVC()
        let second = SecondVC()
        let third = SlidersViewController()
        let forth = DragViewController()
        return [first,second, third, forth]
    }
      
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(segmentView)
        view.addSubview(contentScrollView)
      
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
