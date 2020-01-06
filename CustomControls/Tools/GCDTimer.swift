//
//  GCDTimer.swift
//  CustomControls
//
//  Created by MacBook Pro on 2020/1/3.
//  Copyright © 2020 WJQ. All rights reserved.
//

import UIKit

class GCDTimer: NSObject {
    var block = { }
    var source: DispatchSource?
    static var codeTimer: DispatchSourceTimer?
//    var block: dispatch_block_t?

    override init() {
        super.init()
        var time = dispatch_time_t()
        
        
    }
    

//    class func repeatingTimer(with seconds: TimeInterval, block: @escaping () -> Void) -> GCDTimer? {
//        assert(seconds != 0.0, "Invalid parameter not satisfying: seconds != 0.0")
//        assert(block != nil, "Invalid parameter not satisfying: block != nil")
//
//        let timer = self.init()
//        timer?.block = block
//
//
//        timer?.source = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, DispatchQueue.main)
//        let nsec = UInt64(seconds * Double(NSEC_PER_SEC))
//        dispatch_source_set_timer(timer?.source, DispatchTime.now() + Double(nsec), nsec, 0)
//        dispatch_source_set_event_handler(timer?.source, block)
//        timer?.source.resume()
//
//        return timer
//    }


    class public func repeatingTimerWithTimeInterval(seconds: TimeInterval, completionHandler handler: @escaping (() -> Void) -> Void) {
        
    }
    
    public func fire() {
        
    }
    public func invalidate() {
        
    }
}
