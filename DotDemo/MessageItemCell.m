//
//  MessageItemCell.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MessageItemCell.h"

@implementation MessageItemCell

@synthesize content, sender, bubbleView;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setForUser
{
    content.textAlignment = NSTextAlignmentRight;
    sender.textAlignment = NSTextAlignmentRight;
    bubbleView.layer.cornerRadius = 6.0f;
    bubbleView.layer.masksToBounds = true;
    content.backgroundColor = [UIColor whiteColor];
}

- (void)setForContact
{
    content.textAlignment = NSTextAlignmentLeft;
    sender.textAlignment = NSTextAlignmentLeft;
    bubbleView.layer.cornerRadius = 6.0f;
    bubbleView.layer.masksToBounds = true;
    content.backgroundColor= [UIColor greenColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
