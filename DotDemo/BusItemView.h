//
//  BusItemView.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BusItemView : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *busnumber;
@property (weak, nonatomic) IBOutlet UILabel *waittime;
@property (weak, nonatomic) IBOutlet UIView *busContainerView;

@property (nonatomic) NSInteger time;

@end
