//
//  InfiniteScrollView.swift
//  CustomControls
//
//  Created by MacBook Pro on 2020/1/6.
//  Copyright © 2020 WJQ. All rights reserved.
//

import UIKit
import Foundation

public class InfiniteScrollView: UIScrollView {
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        //获取当前内容的偏移量（左上角）
        var currOffset = contentOffset
        
        //如果x值小于零
        if currOffset.x < 0 {
            //将x更新到滚动视图的末尾
            currOffset.x = contentSize.width - frame.width
        }
            //如果x值大于width-框架宽度(当右上角超出contentSize.width时）
        else if currOffset.x >= contentSize.width - frame.width {
            //将x更新到滚动视图的开头
            currOffset.x = 0
        }
        
        //如果y的值小于零
        if currOffset.y < 0 {
            currOffset.y = contentSize.height - frame.height
        }else if currOffset.y >= contentSize.height - frame.height {
            currOffset.y = 0
        }
        contentOffset = currOffset

    }
}


