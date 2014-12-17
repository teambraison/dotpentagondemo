//
//  LoginViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "Account.h"
#import "DotAPI.h"

@interface LoginViewController : UIViewController <KeyboardViewDelegate, DotLoginDelegate>
@property (weak, nonatomic) IBOutlet UILabel *usernameDisplay;
@property (weak, nonatomic) IBOutlet UILabel *passwordDisplay;
@property (weak, nonatomic) IBOutlet UILabel *usernameSelection;
@property (weak, nonatomic) IBOutlet UILabel *passwordSelection;
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
