//
//  AppStoreReviewManager.swift
//  CustomControls
//
//  Created by 白小嘿 on 2018/12/21.
//  Copyright © 2018 WJQ. All rights reserved.
//

import Foundation
import StoreKit

enum AppStoreReviewManager {
    static func requestReviewIfAppropriate()  {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else {
            // Fallback on earlier versions
        }
    }

}
