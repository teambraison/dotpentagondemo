//
//  BusItemView.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "BusItemView.h"

@implementation BusItemView

@synthesize busnumber, waittime, busContainerView;

- (void)awakeFromNib {
    // Initialization code
    busContainerView.layer.cornerRadius = 8.0f;
    busContainerView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
