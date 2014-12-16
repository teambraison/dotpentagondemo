//
//  MainMenuTableViewCell.h
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

#define HEIGHT 110

@interface MainMenuTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *menuIcon;
@property (weak, nonatomic) IBOutlet UILabel *menuName;
@property (weak, nonatomic) IBOutlet UILabel *menuDescription;
@property (weak, nonatomic) IBOutlet UIView *mainItemView;


@end
