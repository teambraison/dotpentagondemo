//
//  MainMenuTableViewCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MainMenuTableViewCell.h"

@implementation MainMenuTableViewCell

@synthesize menuIcon, menuName, menuDescription, mainItemView;

- (void)awakeFromNib {
    // Initialization code
    mainItemView.layer.cornerRadius = 15.0f;
    mainItemView.layer.masksToBounds = true;
}

- (CGFloat)height
{
    return self.frame.size.height;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
