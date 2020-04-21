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
        var currOffset = contentOffset
        //小于开始部分时
        if currOffset.x < 0 {
            // 让内容移动到结束位置
            currOffset.x = contentSize.width - frame.width
            contentOffset = currOffset
            
        }else if currOffset.x >= contentSize.width - frame.width {//大于结束部分时
            currOffset.x = 0
            contentOffset = currOffset
        }
    }
}


