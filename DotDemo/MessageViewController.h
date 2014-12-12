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
#import "SocketIO.h"
@interface MessageViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, DotDidReceivedChatMessages, SocketIODelegate, SocketIOTransportDelegate>
{
    BLEManager *manager;
}
@property (weak, nonatomic) IBOutlet UILabel *contactName;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UITableView *conversationView;

@property (nonatomic, strong) SocketIO *socketio;
- (void)setContact:(Contact *)theContact;

@end
