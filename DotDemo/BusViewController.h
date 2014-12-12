//
//  BusViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BusItemView.h"
#import "BLEManager.h"

#import <AudioToolbox/AudioServices.h>

@interface BusViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, BLEManagerUpdateDelegate>

@property (weak, nonatomic) IBOutlet UITableView *busTableView;

@end
