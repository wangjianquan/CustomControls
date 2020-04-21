//
//  ALGCDTimer.h
//  AssistedLearning
//
//  Created by wjq on 2019/11/5.
//  Copyright © 2019 wjq. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ALGCDTimer : NSObject

+ (ALGCDTimer *)repeatingTimerWithTimeInterval:(NSTimeInterval)seconds block:(dispatch_block_t)block;

- (void)fire;

- (void)invalidate;


@end



