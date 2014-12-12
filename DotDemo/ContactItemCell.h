//
//  ContactItemCell.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactItemCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *contactImage;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *messageCount;

@end
