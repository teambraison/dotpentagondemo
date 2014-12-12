//
//  MainMenuTableViewCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MainMenuTableViewCell.h"

@implementation MainMenuTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
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
