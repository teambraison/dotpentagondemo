//
//  KeyItemView.m
//  DotDemo
//
//  Created by Titus Cheng on 12/17/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "KeyItemView.h"

@implementation KeyItemView

@synthesize label1,label2, label3, label4, label5, label6, focusedLabel, items;


- (void)awakeFromNib {
    focusedLabel.backgroundColor = [UIColor clearColor];
    focusedLabel.text = @"";
    
    items = [[NSMutableArray alloc] init];
    [items insertObject:label1 atIndex:0];
    [items insertObject:label2 atIndex:1];
    [items insertObject:label3 atIndex:2];
    [items insertObject:label4 atIndex:3];
    [items insertObject:label5 atIndex:4];
    [items insertObject:label6 atIndex:5];
    self.layer.cornerRadius = 6.0f;
    self.layer.masksToBounds = true;
}

- (void)focusOnText:(NSString *)text
{
    focusedLabel.backgroundColor = self.backgroundColor;
    focusedLabel.text = text;
}

- (void)deFocus
{
    focusedLabel.backgroundColor = [UIColor clearColor];
    focusedLabel.text = @"";
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
