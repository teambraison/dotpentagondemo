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
@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DotDidReceivedChatMessages, DotRequestLatestMessageDelegate>
{
    BLEManager *manager;
}
@property (weak, nonatomic) IBOutlet UIView *messageBoxView;
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITableView *conversationView;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;

- (void)setContact:(Contact *)theContact;

@end
