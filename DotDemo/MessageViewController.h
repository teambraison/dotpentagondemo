//
//  MessageViewController.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MessageItemCell.h"
#import "DotAPI.h"
#import "Contact.h"
#import "Account.h"
#import "Message.h"
#import "BLEManager.h"
#import <SIOSocket/SIOSocket.h>
#import "KeyboardViewController.h"


@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DotDidReceivedChatMessages, DotRequestLatestMessageDelegate, KeyboardViewDelegate, BLEManagerUpdateDelegate>
{
    BLEManager *manager;
}
@property (weak, nonatomic) IBOutlet UITableView *conversationView;
@property (weak, nonatomic) IBOutlet UITextField *messageTextView;


- (void)setContact:(Contact *)theContact;

@end
