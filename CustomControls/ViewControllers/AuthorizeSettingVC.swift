//
//  AuthorizeSettingVC.swift
//  NewSG
//
//  Created by z on 2018/11/8.
//  Copyright © 2018年 simpleWQZ. All rights reserved.
//

import UIKit

class AuthorizeSettingVC: UIViewController {

    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    var checkType: CheckType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "权限设置"
        setupUI()
        
    }
    @IBAction func tapGesture(_ sender: UITapGestureRecognizer) {
        dismissAnimation()
    }
    
    func setupUI()  {
        switch checkType {
        case .contact?:
            icon.image = UIImage(named:"bg")
            titleLabel.text = "通讯录权限"
            subTitleLabel.text = "您已禁止访问通讯录权限,请您同意打开通讯录权限,以方便添加好友"
            
        case .photo?:
            icon.image = UIImage(named:"bg")
            titleLabel.text = "相册权限"
            subTitleLabel.text = "打开相册权限才能选择美图哦, 快去打开. 请去-> [设置 - 隐私 - 相册/照片] 打开访问开关"
        
        case .location?:
            icon.image = UIImage(named:"bg")
            titleLabel.text = "定位权限"
            subTitleLabel.text = "打开定位权限才能查看发现周边朋友哦, 快去打开"
        case .video?:
            icon.image = UIImage(named:"bg")
            titleLabel.text = "相机权限"
            subTitleLabel.text = "打开相机权限才能扫描,拍照等操作哦"
        case .audio?:
            icon.image = UIImage(named:"bg")
            titleLabel.text = "麦克风权限"
            subTitleLabel.text = "打开麦克风权限才能录制视屏,发送语音等功能哦"
        default:
            break
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scaleAnimation(self.popView)
    }

    @IBAction func settingAction(_ sender: UIButton) {
        openSettingsURL()
    }
    
    @IBAction func dismiss(_ sender: Any) {
        dismissAnimation()
    }
    
    fileprivate func dismissAnimation() {
        identityAnimation(self.popView)

    }
    
    
}



extension AuthorizeSettingVC {
    // MARK: - 延迟执行
    fileprivate func dispatch_later(block: @escaping ()->()) {
        let t = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: t, execute: block)
    }
    
    func scaleAnimation( _ animateView: UIView) {
        animateView.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.00000001)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
            animateView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { (comp) in

        }
        
//        UIView.animate(withDuration: 0.5, animations: {
//            self.popView.alpha = 1
//        }, completion: nil)
    }
    
    func identityAnimation( _ animateView: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            animateView.transform = CGAffineTransform(scaleX: 0.0000001, y: 0.0000001)
            //            animateView.transform = CGAffineTransform.identity

        }) { (comp) in
            self.dispatch_later {
                self.dismiss(animated: false, completion: nil)
            }
        }
     
    }
}
