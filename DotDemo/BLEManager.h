//
//  BLEManager.h
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LGBluetooth.h"

@protocol BLEManagerUpdateDelegate

- (void)bleDidConnectWithDevice;

@end

@interface BLEManager : NSObject

- (void)startScan;
- (void)connectWith:(LGPeripheral *)peripheral;
- (void)writeData:(NSString *)myData;

+ (BLEManager *)sharedInstance;

@property (weak) id <BLEManagerUpdateDelegate> delegate;

@end
