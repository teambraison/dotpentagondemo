//
//  BLEManager.h
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBluetooth.h"

@interface BLEManager : NSObject

- (void)startScan;
- (void)connectWith:(LGPeripheral *)peripheral;
- (void)writeData:(NSString *)myData;

+ (BLEManager *)sharedInstance;

@end
