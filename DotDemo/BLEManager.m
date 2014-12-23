//
//  BLEManager.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "BLEManager.h"


#define DEVICE_UUID @"0x1800"

#define SERVICE_UUID @"FFA0"
#define CHARACTERISTIC_UUID @"FFF2"

@implementation BLEManager
{
    LGCentralManager *manager;
    LGPeripheral *selectedPeripheral;
}

@synthesize delegate;

+ (BLEManager *)sharedInstance
{
    static BLEManager *_default = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _default = [[self alloc] init];
    });
    return _default;
}


- (id)init
{
    self = [super init];
    if(self) {
    
    }
    return self;
}

- (void)startScan
{
        NSLog(@"Starting scanning...");
    [[LGCentralManager sharedInstance] scanForPeripheralsByInterval:4
                                                         completion:^(NSArray *peripherals)
     {
         if (peripherals.count) {
             LGPeripheral *device = peripherals[0];
             NSLog(@"Found a peripheral %@", device.name);
             [self connectWith:peripherals[0]];
         } else {
             NSLog(@"Can't find any device");
         }
     }];
}

- (void)connectWith:(LGPeripheral *)peripheral
{
    // First of all, opening connection
    [peripheral connectWithCompletion:^(NSError *error) {
        if(error == nil) {
            selectedPeripheral = peripheral;
            [delegate bleDidConnectWithDevice];
            NSLog(@"Connected to %@", selectedPeripheral.name);
            
        } else {
            NSLog(@"Error in connecting: %@ %@", error.debugDescription, error.description);
        }
    }];
}

- (void)writeData:(NSString *)myData
{
    NSLog(@"Writing data %@", myData);
    [LGUtils writeData:[myData dataUsingEncoding:NSUTF8StringEncoding] charactUUID:CHARACTERISTIC_UUID serviceUUID:SERVICE_UUID peripheral:selectedPeripheral completion:^(NSError *error) {
        if(error == nil) {
            NSLog(@"Did write data %@ to device ", myData);
        } else {
            NSLog(@"Failed to write data to device: %@ %@", error.description, error.debugDescription);
        }
    }];
}





@end
