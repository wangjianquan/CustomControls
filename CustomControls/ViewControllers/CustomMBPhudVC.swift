//
//  CustomMBPhudVC.swift
//  CustomControls
//
//  Created by MacBook Pro on 2020/4/22.
//  Copyright © 2020 WJQ. All rights reserved.
//

import UIKit

class CustomMBPhudVC: UIViewController {

    fileprivate lazy var popAnimation : PopAnimation = PopAnimation()
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
    
    lazy var titleBtn : TitleButton = {
        let btn = TitleButton()
        btn.setTitle("popView", for: .normal)
        btn.setTitleColor(red_Color, for: .selected)
        btn.addTarget(self, action: #selector(titleBtnClick(_:)), for: .touchUpInside)
        return btn
    }()
    
    let http200Status = (statusCode: 200, description: "OK")
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = titleBtn


        // Do any additional setup after loading the view.
    }
    
    @IBAction func successAction(_ sender: UIButton) {
        MBProgressHUD.showSuccess("success")
    }
    
    @IBAction func errorAction(_ sender: UIButton) {
        MBProgressHUD.showError("error")
    }

     @IBAction func message(_ sender: UIButton) {
         MBProgressHUD.showMessage("only ლ(′◉❥◉｀ლ)")
     }
    
     @IBAction func topMessage(_ sender: UIButton) {
         MBProgressHUD.showMessage("TopMessage", .top)
     }
    
     @IBAction func bottomMessage(_ sender: Any) {
         MBProgressHUD.showMessage("BottomMessage", .bottom)
     }
     
    
    @IBAction func loading(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        let color = UIColor(r: 153, g: 21, b: 70, alpha: 1.0)
        if sender.isSelected {
            MBProgressHUD.showLoading(color)
        } else {
            MBProgressHUD.showLoading()
        }
        dismiss()
    }
    @IBAction func loadingText(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        let color = UIColor(r: 153, g: 21, b: 170, alpha: 1.0)
        if sender.isSelected {
            MBProgressHUD.showLoading(text: "加载中...",color)
        } else {
            MBProgressHUD.showLoading(text: "加载中...")
        }
        self.dismiss()
    }
   
    @IBAction func loadDetail(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
       
        let color = UIColor(r: 250, g: 121, b: 70, alpha: 1.0)
        if sender.isSelected  {
            MBProgressHUD.showLoading(detailText: "detailText",color)
        } else {
            MBProgressHUD.showLoading(detailText: "detailText")
        }
        dismiss()
    }
    @IBAction func loadingColorAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected

        let color = UIColor(r: 123, g: 26, b: 70, alpha: 1.0)
        if sender.isSelected {
            MBProgressHUD.showLoading(text:"标题", detailText: "子标题", color)
        } else {
            MBProgressHUD.showLoading(text:"标题", detailText: "加载中...加载中...加载中...")
        }
        dismiss()
    }
    
   
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
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

extension CustomMBPhudVC {
    
    fileprivate func dismiss(){
        DispatchQueue.global(qos: .default).async(execute: {
            sleep(2)
            DispatchQueue.main.async(execute: {
                MBProgressHUD.hide(animated: true)
            })
        })
    }
    
    @objc fileprivate func titleBtnClick(_ sender: UIButton) {
        let menuView = PopVC()
        menuView.dataSource = self.dataSource
        let popview_Width : CGFloat  =  SCREEN_WIDTH
        let popview_Height : CGFloat =  CGFloat(self.dataSource.count) * 45 > SCREEN_HEIGHT/2 ? SCREEN_HEIGHT/2 : CGFloat(self.dataSource.count) * 45
        let  popview_y : CGFloat = origin_Y

        popAnimation.presentedFrame = CGRect(x: (SCREEN_WIDTH - popview_Width)/2, y: popview_y, width: popview_Width, height: popview_Height)
        
        popAnimation.presentedCallBack = {[weak self] (isPresented) -> () in
            self?.titleBtn.isSelected = isPresented

            Dlog("标题按钮被点击")
        }
        //3. 设置代理, 并自定义
        menuView.transitioningDelegate = popAnimation
        menuView.modalPresentationStyle = .custom
        present(menuView, animated: true, completion: nil)
        
    }
}
