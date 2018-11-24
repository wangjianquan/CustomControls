//
//  UMTool.swift
//  CustomControls
//
//  Created by aixuexue on 2018/11/23.
//  Copyright © 2018 WJQ. All rights reserved.
//

import UIKit

class UMTool: NSObject {
    
    static func umSetUp() {
        UMConfigure.initWithAppkey(UM_TJ_Appkey, channel: nil)
        UMCommonLogManager.setUp()
        UMConfigure.setLogEnabled(true)
        MobClick.setScenarioType(.E_UM_NORMAL)
        MobClick.setCrashReportEnabled(true)
        let str = UMConfigure.deviceIDForIntegration()
        
        Dlog("\(UMConfigure.umidString() ?? " " )")
        Dlog("\(str!)")
    }

    static func umidString() -> String{
        return UMConfigure.umidString();
    }
}
