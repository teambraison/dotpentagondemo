//
//  KeyItemView.h
//  DotDemo
//
//  Created by Titus Cheng on 12/17/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyItemView : UIView
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;
@property (weak, nonatomic) IBOutlet UILabel *label4;
@property (weak, nonatomic) IBOutlet UILabel *label5;
@property (weak, nonatomic) IBOutlet UILabel *label6;
@property (weak, nonatomic) IBOutlet UILabel *focusedLabel;
@property (strong, nonatomic) NSMutableArray *items;

- (void)deFocus;
- (void)focusOnText:(NSString *)text;

@end
