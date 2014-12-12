//
//  BLEManager.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "BLEManager.h"


#define DEVICE_UUID @"E44DBA07-5A18-F609-D6CB-D7D883808DD9"

#define SERVICE_UUID @"C48A1473-D2E6-4678-AFC9-B610603BFD72"
#define CHARACTERISTIC_UUID @"5810FA38-7699-4226-AFB2-D3B3AA025592"


@implementation BLEManager
{
    LGCentralManager *manager;
    LGPeripheral *selectedPeripheral;
}

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
