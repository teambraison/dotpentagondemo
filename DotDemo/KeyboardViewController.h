//
//  KeyboardViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyItemView.h"
#import "DotViewController.h"

@protocol  KeyboardViewDelegate

- (void)keyboardViewDidFinishInput:(NSString *)value WithKey:(NSString *)key;

@end

@interface KeyboardViewController : DotViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *outputText;

@property (weak, nonatomic) id <KeyboardViewDelegate> delegate;
@property (strong, nonatomic) NSString *key;

//@property (weak, nonatomic) IBOutlet UIView *group1;
//@property (weak, nonatomic) IBOutlet UIView *group2;
//@property (weak, nonatomic) IBOutlet UIView *group3;
//@property (weak, nonatomic) IBOutlet UIView *group4;
//@property (weak, nonatomic) IBOutlet UIView *group5;
//@property (weak, nonatomic) IBOutlet UIView *group6;
//
//@property (weak, nonatomic) IBOutlet UILabel *label1;
//@property (weak, nonatomic) IBOutlet UILabel *label2;
//@property (weak, nonatomic) IBOutlet UILabel *label3;
//@property (weak, nonatomic) IBOutlet UILabel *label4;
//@property (weak, nonatomic) IBOutlet UILabel *label5;
//@property (weak, nonatomic) IBOutlet UILabel *label6;



@end
