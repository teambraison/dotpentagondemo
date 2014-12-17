//
//  ContactViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactItemCell.h"
#import "Account.h"
#import "DotAPI.h"
#import "Contact.h"
#import "MessageViewController.h"
#import "LoginViewController.h"

@interface ContactViewController : UIViewController  <UITableViewDataSource, UITableViewDelegate, DotRequestAllUsersDelegate>
@property (weak, nonatomic) IBOutlet UITableView *contactsmenu;

@end
