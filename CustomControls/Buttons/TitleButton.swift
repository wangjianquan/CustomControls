//
//  TitleButton.swift
//
//  Created by WJQ on 2017/5/24.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class TitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    fileprivate  func setupUI()  {
        setImage(UIImage(named:"rightArrow"), for: .normal)
        setImage(UIImage(named:"downArrow"), for: .selected)
        setTitleColor(.white, for: .normal)
        setTitleColor(.white, for: .selected)
        sizeToFit()
    }
    
    //设置文字图片的间距
    override func setTitle(_ title: String?, for state: UIControl.State) {
        //或者使用imageView?.frame.origin.x = titleLabel!.frame.size.width + 5
        //super.setTitle((title ?? "") + "  ", for: .normal)
        super.setTitle(title, for: .normal)
    }
    //设置文字图片的位置
    override func layoutSubviews() {
        super.layoutSubviews()
        //和OC不同的是,Swift允许我们直接修改一个对象的结构体属性的成员
        titleLabel?.frame.origin.x = 0
        imageView?.frame.origin.x = titleLabel!.frame.size.width + 5
    }
    
}
