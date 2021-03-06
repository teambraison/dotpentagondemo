//
//  MainMenuViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainMenuTableViewCell.h"
#import "ContactViewController.h"
#import "DotViewController.h"
#import "TimeViewController.h"
#import "BusViewController.h"

@interface MainMenuViewController : DotViewController <UITableViewDataSource, UITableViewDelegate>
{
    BLEManager *manager;
}
@property (weak, nonatomic) IBOutlet UITableView *mainMenu;

@end
