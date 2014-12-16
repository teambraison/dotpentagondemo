//
//  AlarmItemCell.h
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlarmItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *alarmTime;
@property (weak, nonatomic) IBOutlet UISwitch *alarmSwitch;
@property (weak, nonatomic) IBOutlet UILabel *amPmLabel;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UIView *alarmItemView;

@end
