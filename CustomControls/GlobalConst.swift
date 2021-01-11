//
//  GlobalConst.swift
//  Classified_Information
//
//  Created by ulinix on 2017/11/6.
//  Copyright © 2017年 wjq. All rights reserved.
//

import Foundation
import UIKit
import Photos


let placeholderI  = UIImage(named: "BannerPlaceHolder")

let ScreenWidth_4               = UIScreen.main.bounds.size.width / 4.0 - 10
let UserDefaults_CDR            = UserDefaults.standard
let UserToken_CDR               = UserDefaults.standard.object(forKey: "token") as? String
let PageSizeNum                 = "10"
let JPushAPPKEY                 = "a06c080ce726b538738b18c9"

/// 判断设备
let iPhone = UIDevice.current.userInterfaceIdiom == .phone
let iPad = UIDevice.current.userInterfaceIdiom == .pad

let appVersion = Bundle.main.infoDictionary! ["CFBundleShortVersionString"] as! String

let iPhone_X = iPhone && (StatusBarHeight > 20)

//================================================================================================================

//1.swift全局常量
let SCALE_WIDTH = UIScreen.main.bounds.size.width / 375
let SCALE_HEIGHT = UIScreen.main.bounds.size.height / 667

let SCREEN_WIDTH = UIScreen.main.bounds.width
let SCREEN_HEIGHT = UIScreen.main.bounds.height

/// 状态栏高度
let StatusBarHeight : CGFloat = UIApplication.shared.statusBarFrame.height
/// 导航高度 + 状态栏的高度
let NavigationBarHeight: CGFloat = 44
let safeBottomHeight: CGFloat = iPhone_X ? 34 : 0
let origin_Y: CGFloat = StatusBarHeight + NavigationBarHeight
let tabBar_Height: CGFloat = getTabBarHeight()
//系统版本
let sysVersion =  UIDevice.current.systemVersion
var IOS10 : Bool? {
     if #available(iOS 11.0, *) {
        return false
    }
    return true
}

let iOS7 = (Double(UIDevice.current.systemVersion) ?? 0.0 >= 7.0)

//本地
let userDef =  UserDefaults.standard
//
let topOffsetY : CGFloat = IOS10 == true ? -64 : 0



//tableview -> backgroundColor
let tableBg_Color = UIColor(red: 247/255.0, green: 247/255.0, blue: 247/255.0, alpha: 1.0)
// 默认红颜色
let red_Color = UIColor(red: 251/255.0, green: 64/255.0, blue: 71/255.0, alpha: 1.0)
/// 淡蓝色
let lightBlue = UIColor(red:0.45, green:0.69, blue:0.95, alpha:1.00)





// App 字体 名
let AlkatipBasma = "ALKATIP Basma Tom"
let AlkatipRukki = "ALKATIP Rukki"
let AppDefaultFont = UIFont.init(name: AlkatipBasma, size: 13)
let RMB = "¥"
let USD = "＄"


/**
    通知 ： NSNotification
*/
let EXIT_LOGIN_NOTIFICATION      = "ExitLogInNotification"
let SUCCESS_LOGIN_NOTIFICATION   = "LogInNotification"
let NOTIFICATION_NETSTASECHANGE_NOTIFICATION = "netConnectStateChange"
let JPUSHNOTIFICATION_NOTIFICATION      = "JPush_notification"


/**
    //全局函数
    // MARK: - 自定义全局Log
 */
func Dlog<T>(_ message : T, file : String = #file, funcName : String = #function, lineNum : Int = #line) {
    
    #if DEBUG
    // 1.获取打印所在的文件
    let fileName = (file as NSString).lastPathComponent
    
    print("\(fileName):  (\(lineNum))-\(message)")
    
    #endif
}

func getLinesWithTwo_Int(_ int : NSInteger) -> CGFloat {
    if int % 2 == 0 {
        return CGFloat(int/2)
    }
    return CGFloat(int/2) + 1
}


func getLinesWithFour(_ array: NSMutableArray) -> CGFloat {
    if array.count % 4 == 0 {
        return CGFloat(array.count/4)
    }
    return CGFloat(array.count/4) + 1
}

func getLinesWithThree(_ array: NSMutableArray) -> CGFloat {
    if array.count % 3 == 0 {
        return CGFloat(array.count/3)
    }
    return CGFloat((array.count/3) + 1)
}

func getLinesWithThree_Count(_ int: NSInteger) -> CGFloat {
    if int % 3 == 0 {
        return CGFloat(int/3)
    }
    return CGFloat((int/3) + 1)
}


func getLinesWithFive(_ array : NSInteger) -> NSInteger {
    if array % 5 == 0 {
        return (array/5)
    }
    return (array/5) + 1
}


func getlinesWithRandomNumber(_ array: NSMutableArray) -> NSInteger {
    if array.count % 6 == 0 {
        return (array.count/6)
    }
    return (array.count/6) + 1
}






/*
 ** 公共方法
 */

// MARK: - 文本高度
func get_heightForComment(_ str: String) -> CGFloat {
    let rect = NSString(string: str).boundingRect(with: CGSize(width: SCREEN_WIDTH-30, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: UIFont.init(name: AlkatipBasma, size: 13)!], context: nil)
    return rect.height
}

// MARK: - 将PHAsset对象转为UIImage对象
func PHAssetToUIImage(asset: PHAsset) -> UIImage {
    var image = UIImage()
    // 新建一个默认类型的图像管理器imageManager
    let imageManager = PHImageManager.default()
    // 新建一个PHImageRequestOptions对象
    let imageRequestOption = PHImageRequestOptions()
    // PHImageRequestOptions是否有效
    imageRequestOption.isSynchronous = true
    // 缩略图的压缩模式设置为无
    imageRequestOption.resizeMode = .none
    
    // 缩略图的质量为高质量，不管加载时间花多少
    //    imageRequestOption.deliveryMode = .highQualityFormat
    // 按照PHImageRequestOptions指定的规则取出图片 PHImageManagerMaximumSize
    imageManager.requestImage(for: asset, targetSize: CGSize(width:200, height:200), contentMode: .aspectFill, options: imageRequestOption, resultHandler: {
        (result, _) -> Void in
        image = result!
        
    })
    return image
    
}

public func getTabBarHeight() -> CGFloat {
    let height: CGFloat = UIDevice.current.isIPhoneX() == true ? 83 : 49
    return height
}



/*
 *** extension集合
 */


extension UIFont {
    class func costumFont (ofSize : CGFloat) -> UIFont {
        return UIFont.init(name: AlkatipBasma, size: ofSize) ?? UIFont.systemFont(ofSize: ofSize+2)
    }
}

func getFontName() -> String {
    let familyNames = UIFont.familyNames
    for index in 0...(familyNames.count-1) {
        let familyName = familyNames[index]
        let fontNames = UIFont.fontNames(forFamilyName:familyName)
        if fontNames.count >= 1 {
            for j in 0...(fontNames.count-1) {
                _ = fontNames[j]
            }
        }
    }
    return familyNames.randomElement() ?? "Dark Blue"
}

func openSettingsURL() {
    let url = URL(string: UIApplication.openSettingsURLString)
    if let url = url , UIApplication.shared.canOpenURL(url){
        if #available(iOS 10, *){
            UIApplication.shared.open(url, options: [:], completionHandler: { (success) in
               print("授权界面")
            })
        }else{
            UIApplication.shared.openURL(url)
        }
    }
}

//MARK: 字符串截取
func customSubstring(_ str: String) -> [String] {
    let index = str.index(str.startIndex, offsetBy: 4)
    let year = str.prefix(upTo: index)
    let startIndex = str.index(str.startIndex, offsetBy:5)//获取d的索引
    let endIndex = str.index(startIndex, offsetBy:2)//从d的索引开始往后两个,即获取f的索引
    let month = str[startIndex..<endIndex]
    return [String(year),String(month)]
}

extension UIDevice {
    public func isIPhoneX() -> Bool {
        if UIApplication.shared.statusBarFrame.height > 20 {
            return true
        }
        return false
    }
    
    public func isiPhone5() -> Bool {
        if UIScreen.main.bounds.height == 568 {
            return true
        }
        return false
    }
}

extension UIViewController {
    

    func errorCode(code: Int? ){
        if code == 403 {
            NotificationCenter.default.post(name: Notification.Name(rawValue:EXIT_LOGIN_NOTIFICATION), object: nil)
        }
    }
    
    
    
    
    func callPhone(_ phoneNumber: String)  {
        //            //拨打电话进行报警
        let urlString = "tel://\(phoneNumber)"
        if let url = URL(string: urlString) {
            //根据iOS系统版本，分别处理
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:],completionHandler: {(success) in
                })
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    
    //播放动画，是否选中的图标改变时使用
    func scaleAnimate( _ cellView: UIView) {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2,
                                                       animations: {
                                                        cellView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                                    })
                                    
        }, completion: nil)
    }
    
    func AnimateScale( _ cellView: UIView) {
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.2,
                                                       animations: {
                                                        cellView.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                                    })
                                    
        }, completion: nil)
    }
    
    func identityAnimate( _ cellView: UIView) {
        
        UIView.animateKeyframes(withDuration: 0.4, delay: 0, options: .allowUserInteraction,
                                animations: {
                                    UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.4,
                                                       animations: {
                                                        cellView.transform = CGAffineTransform.identity
                                    })
        }, completion: nil)
    }
    
}






