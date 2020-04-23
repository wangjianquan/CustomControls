//
//  WjPresentationCoutroller.swift
//  Classified_Information
//
//  Created by ulinix on 2017/11/9.
//  Copyright © 2017年 wjq. All rights reserved.
//

import UIKit

class WjPresentationCoutroller: UIPresentationController {
    
    var presentedFrame: CGRect = CGRect.zero
    
    override func containerViewWillLayoutSubviews() {
        // containerView  容器视图,所有modal的视图都被添加到它上
        // presentedView () 拿到弹出视图
        presentedView?.frame = presentedFrame
        
        //初始化蒙版
        setUpMaskView()
    }
    
    
    

}


extension WjPresentationCoutroller {
    
    fileprivate func setUpMaskView() {
        
        //创建蒙版
        let maskView = UIView(frame: (containerView?.bounds)!)
        maskView.backgroundColor = UIColor (white: 0.7, alpha: 0.2)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(maskViewClick))
        maskView.addGestureRecognizer(tapGesture)
        
        //将蒙版添加到容器视图中
        containerView?.insertSubview(maskView, belowSubview: presentedView!)
        
    }
    //MARK : -- 点击蒙版 ， 弹出视图消失
    @objc fileprivate func maskViewClick (){
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}







