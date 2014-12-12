//
//  MessageItemCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MessageItemCell.h"

@implementation MessageItemCell

@synthesize content, sender;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setForUser
{
    content.textAlignment = NSTextAlignmentRight;
    sender.textAlignment = NSTextAlignmentRight;
    content.layer.cornerRadius = 10;
    content.backgroundColor = [UIColor whiteColor];
}

- (void)setForContact
{
    content.textAlignment = NSTextAlignmentLeft;
    sender.textAlignment = NSTextAlignmentLeft;
    content.layer.cornerRadius = 10;
    content.backgroundColor= [UIColor greenColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
