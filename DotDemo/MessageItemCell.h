//
//  MessageItemCell.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *sender;

- (void)setForUser;
- (void)setForContact;

@end
