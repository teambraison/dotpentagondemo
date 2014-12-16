//
//  DotViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLEManager.h"
#import <AudioToolbox/AudioServices.h>

@interface DotViewController : UIViewController <BLEManagerUpdateDelegate>
@property (weak, nonatomic) IBOutlet UIView *alertView;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;


@end
