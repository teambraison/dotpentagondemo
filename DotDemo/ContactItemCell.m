//
//  ContactItemCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "ContactItemCell.h"

@implementation ContactItemCell
@synthesize contactImage, contactName, messageCount, contactContainerView;

- (void)awakeFromNib {
    // Initialization code
    contactImage.layer.cornerRadius = 25.0f;
    contactImage.layer.masksToBounds = true;
    
    contactContainerView.layer.cornerRadius = 6.0f;
    contactContainerView.layer.masksToBounds = true;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
