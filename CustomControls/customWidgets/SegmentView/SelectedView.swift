//
//  SelectedView.swift
//  CATransform3D_Demo
//
//  Created by wjq on 2017-12-07.
//  Copyright © 2017 WJQ. All rights reserved.
//

import UIKit

// animateLine位置枚举
enum AnimateLineOriginType {
    case leading
    case center
}

let lineWidth: CGFloat = 30
let line_height: CGFloat = 2

class SelectedView: UIView {
   
    var btnCallBack: ((_ seleected_Index: Int) -> ())?
    //未选中文字颜色
    var title_NorColor: UIColor? = UIColor.darkGray{
        didSet{
            setupColor()
        }
    }
    
    //选中颜色
    var title_SelectColor: UIColor? = UIColor.red {
        didSet{
            setupColor()
        }
    }
    
    //View背景色
    var bgColor: UIColor = UIColor(white: 0.98, alpha: 1.0) {
        didSet{
            self.backgroundColor = bgColor
        }
    }
    
    //下划线origin.x,  default is center
    var animateLineOrigin: AnimateLineOriginType? {
        didSet{
            guard let array = titles else { return  }
            let item_Width = self.frame.size.width / CGFloat(array.count)
            if animateLineOrigin == .center {
                animateLine.frame.origin.x =  (item_Width - lineWidth) / 2
                 animateLine.frame.size.width = lineWidth
            }else{
                animateLine.frame.origin.x = 0
                animateLine.frame.size.width = item_Width
            }
        }
    }
    
    
//    //底部动画lineView
    fileprivate lazy var animateLine: UIView = UIView()

    fileprivate var allItem = [UIButton]()

    //下划线隐藏, default is false
    var hiddenLine: Bool = false {
        didSet{
            animateLine.isHidden = hiddenLine
        }
    }
    var currentBtn: UIButton?
    //MARK: 必传 
    var titles: [String]? {
        didSet{
            guard let titleArr = titles else { return }
            let item_Width = self.frame.size.width / CGFloat(titleArr.count)
            let item_height = self.frame.size.height
            
            for i in 0..<titleArr.count {
                let  btn = UIButton(type: .custom)
                btn.frame = CGRect(x:  CGFloat(i) * item_Width, y: 0, width: item_Width, height: item_height-2)
                btn.setTitle((titleArr[i]), for: .normal)
                btn.setTitleColor(title_NorColor, for: .normal)
                btn.setTitleColor(title_SelectColor, for: .selected)
                btn.layer.cornerRadius = 3
                btn.layer.masksToBounds = true
                btn.tag = 100 + i
                btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
                allItem.append(btn)
                self.addSubview(btn)
            }
            
            //默认选中第0个按钮
            self.currentIndex = 0
            if animateLineOrigin == .center {
                animateLine.frame.origin.x = (item_Width - lineWidth) / 2
                animateLine.frame.size.width = lineWidth
            }else{
                animateLine.frame.origin.x = 0
                animateLine.frame.size.width = item_Width
            }
            animateLine.frame.origin.y = item_height - line_height
            animateLine.frame.size.height = line_height
            animateLine.backgroundColor = title_SelectColor
            //添加底部动画view
            self.addSubview(animateLine)
        }
    }
    fileprivate var lastIndex: Int = 0
    //MARK:选中标题中第几个按钮, 默认选中首个按钮
    var currentIndex: Int = 0 {
        didSet{
            if self.allItem.count == 0 {return}
            let btn = self.allItem[currentIndex]
            btn.isSelected = true
            
            
            if currentIndex != self.lastIndex {
                let lastBtn = self.allItem[lastIndex]
                lastBtn.isSelected = false
                self.lastIndex = currentIndex
                
                let width = self.frame.size.width / CGFloat(allItem.count)
                
                UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
                    if self.animateLineOrigin == .center {
                        self.animateLine.frame.origin.x = CGFloat(self.currentIndex) * width + (width - lineWidth) / 2
                    }else{
                        self.animateLine.frame.origin.x  =  CGFloat(self.currentIndex) * width
                    }
                    self.animateLine.layoutIfNeeded()
                }, completion: nil)
                
                if btnCallBack != nil  {
                    btnCallBack!(currentIndex)
                }
            }
            
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    
    fileprivate func setUp() {
        self.allItem = [UIButton]()
        animateLineOrigin = AnimateLineOriginType.center
        self.backgroundColor = bgColor
        
    }
    
    func setupColor() {
        for btn in allItem {
            btn.setTitleColor(title_NorColor, for: .normal)
            btn.setTitleColor(title_SelectColor, for: .selected)
            animateLine.backgroundColor = title_SelectColor
        }
    }
    

}



extension SelectedView  {
    
    @objc fileprivate func btnClick (_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        self.currentIndex = sender.tag - 100
    }
    
}










