//
//  TimeViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "DotViewController.h"
#import "AlarmItemCell.h"

@interface TimeViewController : DotViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *alarmTableView;
@property (weak, nonatomic) IBOutlet UIView *mainTimeView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeIndicatorLabel;
@property (weak, nonatomic) IBOutlet UIView *currentTimeContainer;

@end
