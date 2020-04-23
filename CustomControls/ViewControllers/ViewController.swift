//
//  ViewController.swift
//  LoadingView
//
//  Created by landixing on 2018/7/27.
//  Copyright © 2018年 WJQ. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController{
    
    @IBOutlet weak var search: SearchView!
    @IBOutlet weak var progressView: ProgressView!
    @IBOutlet weak var circlePro: CircleProgressView!
    @IBOutlet weak var placeTextView: UIPlaceHoderTextView!
    
    @IBOutlet weak var badgeButton: UIButton!

    
    lazy var selectView: SelectedView = {
        let seleView = SelectedView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 44))
        seleView.title_SelectColor = .red
        seleView.title_NorColor = .black
        seleView.bgColor = .groupTableViewBackground
        seleView.animateLineOrigin = .center // default is center
        seleView.titles = ["基本信息","案件信息","跟进记录"]
        seleView.btnCallBack = { [weak self]  (index) in
            Dlog("点击第\(index)个按钮")
            self?.badgeBtn.badgeValue = String(format: "%d", (index+1)*10)
            self?.badgeButton.badgeValue = String(format: "%d", (index+3)*10)
           
        }
        return seleView
    }()
    
    // MARK: - 搜索栏
    lazy var naviSearchView: SearchView = {
        let searchView = SearchView()
        searchView.frame = CGRect(x: 0, y: 0, width:230, height: 44)
        searchView.layer.cornerRadius = 3
        searchView.layer.masksToBounds = true
        searchView.placeHolder = "请输入关键字"
        
        return searchView
    }()
    
    // MARK: - 测试
    lazy var edage: EdgeLabel = {
        let label = EdgeLabel()
        label.center.x = 15
        label.center.y = 100
        label.wj_size.width = UIScreen.main.bounds.size.width - 30
        let string = "开始: QWERTYUI欧普拉科技和规范的撒下次VB你们,破以一天热瓦水电费规划局快乐美女吧变成现在阿斯顿法国和健康"
        label.wj_size.height = string.contentHeight(titleText: string)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.edgeInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        label.setEdgeLabelStyle(textColor: .white, bgColor: .black)
        label.setAttribute(text: string, rangeString:"开始: " )
        return label
    }()
    
    // MARK: -  标题按钮
    fileprivate lazy var titleBtn : TitleButton = {
        let titleBtn = TitleButton()
        titleBtn.setTitle("Codable(回显)", for: .normal)
        titleBtn.frame =  CGRect(x: 20, y:  selectView.frame.origin.y + selectView.frame.size.height + 15, width:150, height: 35)
        titleBtn.backgroundColor = .black
        titleBtn.isSelected = false
        titleBtn.addTarget(self, action: #selector(ViewController.titleBtnClick(_:)), for: .touchUpInside)
        return titleBtn
    }()

    lazy var badgeBtn: UIButton = {
        let badgeBtn = UIButton(frame: CGRect(x: 0, y: 300, width: 88, height: 35))
        badgeBtn.badgeValue = "120"
        badgeBtn.badgeBGColor = UIColor.orange
        badgeBtn.badgeFont = UIFont.systemFont(ofSize: 8)
        badgeBtn.badgeTextColor = UIColor.black
        badgeBtn.badgeOriginX = 10
        badgeBtn.badgeOriginY = -8
        badgeBtn.setBackgroundImage(UIImage(named: "bg"), for: .normal)
        return badgeBtn
    }()
    var bookdata =  Data()
    var infodata =  Data()
     
      
      
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.titleView?.translatesAutoresizingMaskIntoConstraints = false
        self.navigationItem.titleView = naviSearchView
        view.addSubview(selectView)
        view.addSubview(titleBtn)
        view.addSubview(edage)
        view.addSubview(badgeBtn)
        badgeButton.badgeValue = "80"
        
       
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
      
//    let authorizeTool = AuthorizeTool.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        authorize()
//        _ = audioAuthorize()
        MobClick.beginLogPageView("\(type(of: self))")


        authorizeCheck { (photoAuthStatus) in
            if photoAuthStatus == .denied {
                DispatchQueue.main.async(execute: {
                    let vc = AuthorizeSettingVC.init(nibName: "AuthorizeSettingVC", bundle: nil)
                    vc.checkType = .audio
                    vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
                    vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                    UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: false, completion: nil)
                })
            }else{

            }
        }
    }
   
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        MobClick.endLogPageView("\(type(of: self))")
    }
    // MARK: - 标题按钮
    @objc fileprivate func titleBtnClick(_ btn: TitleButton) {
        btn.isSelected = !btn.isSelected
        let vc = FirstVC()
        self.navigationController?.pushViewController(vc, animated: true)

        MobClick.event("1")
        MobClick.event("2")

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func valueChange(_ sender: UISlider) {
        self.progressView.progress = CGFloat(sender.value)

    }
    
      
      @IBAction func segmentPush(_ sender: Any) {
            self.navigationController?.pushViewController(ContentViewController(), animated: true)

      }
    @IBAction func pushShareVC(_ sender: UIButton) {
        let shareVC = ShareViewController()
        shareVC.shareBlock = { [unowned self] (model) in
            MBProgressHUD.showMessage(model.title)
        }
        let animator = FromBottomAnimator(presentedViewController: shareVC, presenting: self)
        shareVC.transitioningDelegate = animator
        self.present(shareVC, animated: true, completion: nil)
    }
    
    @IBAction func DragAction(_ sender: UIButton) {
        self.navigationController?.pushViewController(DragViewController(), animated: true)

    }
    
}

extension ViewController {

    func authorizeCheck(_ authorizeBlock: @escaping (PHAuthorizationStatus) -> Void) {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { (request) in
                if request == .denied {
                    authorizeBlock(request)
                }
            }
        case .authorized:
            authorizeBlock(status)
        case .denied,.restricted :
            authorizeBlock(status)
         default:
            break
        }
    }
    func audioAuthorize() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
            
        case .notDetermined:
            // 请求授权
            AVCaptureDevice.requestAccess(for: .audio) { (status) in
                DispatchQueue.main.async(execute: {
                    _ = self.audioAuthorize()
                })
            }
        case .authorized:
            return true
        default: ()
            let vc = AuthorizeSettingVC.init(nibName: "AuthorizeSettingVC", bundle: nil)
            vc.checkType = .audio
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: false, completion: nil)
            
        }
        return false
    }
}

class WJAuthorize {
    static let shared = WJAuthorize()
    private init() {}
    
    func photoAuthorize(statusBlock: @escaping (PHAuthorizationStatus)->() ) {
       
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized{
            statusBlock(status)
        } else if status == .notDetermined { // 未授权，请求授权
            PHPhotoLibrary.requestAuthorization({ (state) in
                DispatchQueue.main.async(execute: {
                    statusBlock(state)
                })
            })
            statusBlock(status)
        } else {
            statusBlock(status)
        }
    }

   
    func videoAuthorize(authorizedBlock: @escaping ()->Void, unAuthorize unAuthorizeBlock: @escaping ()->Void ) {
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { (ist) in
            let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
            if status == .authorized {//获得权限
               authorizedBlock()
            }else if (status == .denied) || (status == .restricted) {
               unAuthorizeBlock()
            }
        })
    }
    
    // 用户是否开启相机权限
    func authorizeCamaro(authorizeClouse:@escaping (AVAuthorizationStatus)->()){
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        if status == .authorized{
            authorizeClouse(status)
        } else if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted) in
                if granted == false {  // 允许
                    authorizeClouse(.denied)
                }
            })
        } else {
            authorizeClouse(status)
        }
    }
    
}


extension NSAttributedString {
    convenience init(html: String) throws {
        let dic = [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html]
        guard let data = html.data(using: .utf8) else {
            self.init()
            return
        }
        try self.init(data: data, options: dic, documentAttributes: nil)
    }
}


























