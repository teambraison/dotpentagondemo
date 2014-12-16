//
//  AlarmItemCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "AlarmItemCell.h"

@implementation AlarmItemCell

@synthesize alarmTime, alarmSwitch, amPmLabel, daysLabel, alarmItemView;

- (void)awakeFromNib {
    // Initialization code
    alarmItemView.layer.cornerRadius = 6.0f;
    alarmItemView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
