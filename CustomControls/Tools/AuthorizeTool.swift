//
//  AuthorizeTool.swift
//  NewSG
//
//  Created by z on 2018/11/8.
//  Copyright © 2018年 simpleWQZ. All rights reserved.
//

import Foundation
import AVFoundation
import Photos
import Contacts

enum CheckType {
    case contact
    case photo
    case location
    case video
    case audio
}



class AuthorizeTool: NSObject {
    
    static let sharedInstance = AuthorizeTool()
    private override init() {}
    
    func contactAuthorizationStatus() -> CNAuthorizationStatus {
        var authStatus = CNAuthorizationStatus.authorized
        let status  = CNContactStore.authorizationStatus(for: .contacts)
        if status == .notDetermined {
            authStatus = status
        } else if (status == .denied){
            authStatus = status
        } else if (status == .authorized){
            authStatus = status
        }
        return authStatus
    }
    
    func avcaptureAuthStatus() -> AVAuthorizationStatus  {
        let authostatus = AVCaptureDevice.authorizationStatus(for: .video)
        return authostatus
    }
    
    func photoAuthStatus() -> Bool {
        let photo = false
        let library:PHAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if(library == .denied || library == .restricted){
            return photo == false
        } else {
            return photo == true
        }
    }
    
   
    //MARK: -- 相机权限
    func videoAuthorize() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            // 请求授权
            AVCaptureDevice.requestAccess(for: .video) {[weak self] (status) in
                DispatchQueue.main.async(execute: {
                    _ = self?.videoAuthorize()
                })
            }
            return false
        case .authorized:
            return true
        case .denied, .restricted :
            popVC(.video)
            return false
        }
    }
    
    //MARK: -- 麦克风权限
    func audioAuthorize() -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .notDetermined:
            // 请求授权
            AVCaptureDevice.requestAccess(for: .audio) {[weak self] (status) in
                DispatchQueue.main.async(execute: {
                    _ = self?.audioAuthorize()
                })
            }
            return false
        case .authorized:
            return true
        case .denied, .restricted :
            popVC(.audio)
           return false
        }
    }
    
    //MARK: -- 通讯录权限
    func contactAuthorize() {
        let status  = CNContactStore.authorizationStatus(for: .contacts)
        switch status {
        case .notDetermined:
            CNContactStore().requestAccess(for: .contacts) {[weak self] (authed, error) in
                if authed == false {
                    DispatchQueue.main.async(execute: {
                        self?.contactAuthorize()
                    })
                }else{
                    print("通讯录授权失败")
                }
            }
        case .authorized:
            print("通讯录已授权")
            
        case .denied,.restricted :
            popVC(.contact)
        default:
            break
        }
    }
    
    //MARK: -- 相册权限
    func photoAuthorize() {
        let status = PHPhotoLibrary.authorizationStatus()
        switch status {
        case .notDetermined:
            print("相册请求授权")
            PHPhotoLibrary.requestAuthorization { (status) in
                DispatchQueue.main.async(execute: {
                    self.photoAuthorize()
                })
            }
        case .authorized:
            print("相册已授权")
            
        case .denied,.restricted :
            popVC(.photo)
        default:
            break
        }
    }
    
    fileprivate func popVC(_ type: CheckType) {
        DispatchQueue.main.async(execute: {
            let vc = AuthorizeSettingVC.init(nibName: "AuthorizeSettingVC", bundle: nil)
            vc.checkType = type
            vc.view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            vc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            UIApplication.shared.keyWindow?.rootViewController?.present(vc, animated: false, completion: nil)
        })
    }
    
}
