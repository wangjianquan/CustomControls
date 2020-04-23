//
//  DragViewController.swift
//  CustomControls
//
//  Created by landixing on 2018/9/27.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

fileprivate let item_WH: CGFloat = 88
fileprivate let radius = item_WH/2

class DragViewController: UIViewController {

    
    //动画
    var circleAnimator: UIViewPropertyAnimator!
    // 记录拖动时的圆形视图 center
    var circleCenter: CGPoint!
    
    fileprivate lazy var titleBtn : TitleButton = {
        let titleBtn = TitleButton(frame: CGRect(x: 0, y:  0, width:150, height: 35))
        titleBtn.setTitle("列表", for: .normal)
        titleBtn.isSelected = false
        titleBtn.addTarget(self, action: #selector(DragViewController.titleBtnClick(_:)), for: .touchUpInside)
        return titleBtn
    }()
    
    lazy var circle: UIView = {
        let circle = UIView(frame: CGRect(x: 0.0, y: 0.0, width: item_WH, height: item_WH))
        circle.center = self.view.center
        circle.layer.cornerRadius = radius
        circle.layer.masksToBounds = true
        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: item_WH, height: item_WH))
        btn.setImage(UIImage(named: "tiger"), for: .normal)
        btn.addTarget(self, action: #selector(DragViewController.btnAction), for: .touchUpInside)
        circle.addSubview(btn)
        return circle
    }()
    
    lazy var shadow: UIView = {
        let shadow = UIView()
        shadow.frame.origin = CGPoint(x: 0, y: 0)
        shadow.frame.size = UIScreen.main.bounds.size
//        shadow.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.5)
//        shadow.isHidden = true
        shadow.backgroundColor = .black
        shadow.alpha = 0
        return shadow
    }()
    lazy var topView: UIView = {
        let topView = UIView()
        topView.frame.origin.x = 0
        topView.frame.origin.y = -44
        topView.frame.size = CGSize(width: UIScreen.main.bounds.size.width, height: 44)
        topView.backgroundColor = .white
        return topView
    }()
    
    
    lazy var userNameField: FloatTitleTextField = {
        let field = FloatTitleTextField(frame: CGRect(x: 23, y: 23, width: UIScreen.main.bounds.size.width - 46, height: 66))
        field.placeholder = "userName"
        field.titleTextColour = .blue
        if let fnt = UIFont(name:"Verdana-Bold", size:13) {
            field.titleFont = fnt
        }
        return field
    }()
    
    lazy var passWordField: FloatTitleTextField = {
        let field = FloatTitleTextField(frame: CGRect(x: 23, y: userNameField.frame.size.height + userNameField.frame.origin.y + 15, width: UIScreen.main.bounds.size.width - 46, height: 66))
        field.placeholder = "password"
        field.titleTextColour = .blue

        if let fnt = UIFont(name:"Trebuchet-BoldItalic", size:13) {
            field.titleFont = fnt
        }
        return field
    }()
    
    ///设置状态栏背景颜色
    func setStatusBarBackgroundColor(color : UIColor) {
        if #available(iOS 13.0, *) {
            let statusBar = UIView(frame: UIApplication.shared.keyWindow?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero)
            statusBar.backgroundColor = color
            UIApplication.shared.keyWindow?.addSubview(statusBar)
       } else {
            let statusBarWindow : UIView = UIApplication.shared.value(forKey: "statusBarWindow") as! UIView
            let statusBar :UIView = statusBarWindow.value(forKey:"statusBar")as!UIView
            if statusBar.responds(to:#selector(setter: UIView.backgroundColor)) {
                statusBar.backgroundColor = color
            }
       }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        navigationItem.titleView = titleBtn
        self.view.addSubview(self.userNameField)
        self.view.addSubview(self.passWordField)
        self.view.addSubview(self.circle)
        view.addSubview(self.shadow)
        view.insertSubview(self.topView, aboveSubview: self.shadow)
        shadow.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapShadow)))

        //拖动手势
        circle.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(dragCircle)))


        let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        btn.setImage(UIImage(named: "img_search"), for: .normal)
        btn.backgroundColor = .yellow
        let rightButton = BadgeBarButtonItem(customButton: btn)
        rightButton.badgeValue = "100";
//        rightButton.badgeOriginX = 7;
        rightButton.badgeOriginY = -7;
//        rightButton.badgeBGColor = .blue
//        rightButton.badgeTextColor = .white
//        rightButton.badgeFont = UIFont.systemFont(ofSize: 12)
//        rightButton.badgePadding = 6
//        rightButton.badgeMinSize = 5
        // Add it as the leftBarButtonItem of the navigation bar
        self.navigationItem.rightBarButtonItem = rightButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        MobClick.beginLogPageView("\(type(of: self))")
        Dlog(getFontName())
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        MobClick.endLogPageView("\(type(of: self))")
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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

// MARK: - 点击事件
extension DragViewController {
    
    fileprivate func showTopView() {
        UIView.animate(withDuration: 0.5) {
            self.shadow.alpha = 0.3
            self.topView.frame.origin.y = 0
        }
    }
    fileprivate func dismissTopView() {
        UIView.animate(withDuration: 0.5) {
            self.shadow.alpha = 0.0
            self.topView.frame.origin.y = -44
            self.titleBtn.isSelected = false
        }
    }

    //MARK: --标题按钮
    @objc fileprivate func titleBtnClick(_ btn: TitleButton) {
        btn.isSelected = !btn.isSelected
        if btn.isSelected == true {
            showTopView()
        } else {
           dismissTopView()
        }
    }
    
    @objc func btnAction() {
        MobClick.event("5")
        self.navigationController?.pushViewController(FirstVC(), animated: true)
    }
    //MARK: 手势
    @objc func dragCircle(gesture: UIPanGestureRecognizer) {
        let target = gesture.view!
        switch gesture.state {
        case .began:
            if circleAnimator != nil && circleAnimator.isRunning {
                circleAnimator.stopAnimation(false)
            }
            circleCenter = target.center
        case .changed:
            let translation = gesture.translation(in: self.view)
            target.center = CGPoint(x: circleCenter.x + translation.x, y: circleCenter.y + translation.y)
        case .ended:
            
            let translation = gesture.translation(in: self.view)
            var end_X = self.circleCenter.x + translation.x
            var end_Y = self.circleCenter.y + translation.y
            
            if end_X <= 60 || end_X <= UIScreen.main.bounds.size.width/2{
                end_X = 60
            }else if end_X >= UIScreen.main.bounds.size.width/2 {
                end_X = (UIScreen.main.bounds.size.width-radius-10)
            }
            if end_Y <= 55 {
                end_Y = 60
            }else if end_Y >= UIScreen.main.bounds.size.height-88-item_WH {
                end_Y = (UIScreen.main.bounds.size.height-item_WH-radius-10)
            }
            let v = gesture.velocity(in: target)
            // 在y轴上的速度分量通常被忽略，当对于视图的center为动画主体时会使用
            let velocity = CGVector(dx: v.x / UIScreen.main.bounds.size.width, dy: v.y / UIScreen.main.bounds.size.height)
            //阻尼系数（damping）、质量参数（mass）、刚性系数（stiffness）和初始速度（initial velocity）
            let springParameters = UISpringTimingParameters(mass: 2.5, stiffness: 150, damping: 23, initialVelocity: velocity)
            circleAnimator = UIViewPropertyAnimator(duration: 0.0, timingParameters: springParameters)
            
            circleAnimator!.addAnimations({
                target.center = CGPoint(x: end_X, y: end_Y)
            })
            circleAnimator!.startAnimation()
        default:
            break
        }
    }
    
    @objc  func tapShadow(gesture: UITapGestureRecognizer){
        dismissTopView()
    }
}
