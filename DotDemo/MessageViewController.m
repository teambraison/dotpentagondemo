//
//  MessageViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
{
    NSMutableArray *messagelist;
    DotRequestMessagesAPI *messagesAPI;
    DotRequestLatestMessageAPI *latestMessageAPI;
    DotSendMessageAPI *sendMessageAPI;
    Account *account;
    Contact *contact;
    SIOSocket *socketio;
}

@end

@implementation MessageViewController

@synthesize contactName, messageLabel, conversationView, messageBoxView, sendButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    messageBoxView.layer.cornerRadius = 6.0f;
    messageBoxView.layer.masksToBounds = true;
    
    sendButton.layer.cornerRadius = 6.0f;
    sendButton.layer.masksToBounds = true;
    
    manager = [BLEManager sharedInstance];
    [manager startScan];
    conversationView.delegate = self;
    conversationView.dataSource = self;
    
    [self.conversationView registerNib:[UINib nibWithNibName:@"MessageItemCell" bundle:nil] forCellReuseIdentifier:@"messagecell"];
    
    if(contact != nil) {
        contactName.text = contact.username;
    }
    
    account = [Account sharedInstance];
    if(account == nil) {
        NSLog(@"account is nil at messaging");
    } else {
        NSLog(@"Account is not nil at messaging with username: %@ and user_id: %@", account.user_name, account.user_id);
    }
    
    messagesAPI = [[DotRequestMessagesAPI alloc] init];
    messagesAPI.delegate = self;
    
    sendMessageAPI = [[DotSendMessageAPI alloc] init];
    
    latestMessageAPI = [[DotRequestLatestMessageAPI alloc] init];
    latestMessageAPI.delegate = self;
    
    
    messagelist = [[NSMutableArray alloc] init];
    
    [SIOSocket socketWithHost: @"http://localhost:3000" response: ^(SIOSocket *socket) {
        self->socketio = socket;
        NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
        [userData setObject:account.user_name forKey:@"user_name"];
        [userData setObject:account.user_id forKey:@"user_id"];
        [socket emit:@"join" args:@[userData]];
    }];
    
    
    [messagesAPI requestMessagesWith:account.user_id AndContact:contact.userid WithSession:account.session_id];
    
//    [NSTimer scheduledTimerWithTimeInterval:2.0
//                                     target:self
//                                   selector:@selector(fetchNewMessage)
//                                   userInfo:nil
//                                    repeats:true];
}

- (void)fetchNewMessage
{
    NSLog(@"Fetching new message");
    [latestMessageAPI requestLatestMessageWith:account.user_id AndContact:contact.userid];
}

- (void)dotDidReceivedLatestMessage:(NSDictionary *)data
{
    NSLog(@"Receiving latest messsage %@", data);
}




- (void)setContact:(Contact *)theContact
{
    contact = theContact;
}
- (IBAction)sendMessageButtonPressed:(id)sender {
//    NSMutableDictionary *messageData = [[NSMutableDictionary alloc] init];
//    [messageData setObject:account.user_id forKey:@"user_id"];
//    [messageData setObject:@"A simple test data" forKey:@"message"];
//    [socketio sendEvent:@"new_msg" withData:messageData andAcknowledge:^(id argsdata){
//        NSLog(@"Successfully send data");
//    }];
//    [sendMessageAPI sendMessageWithSession:account.session_id AndSenderID:account.user_id AndReceiver:contact.userid AndMessage:@"A test data"];
    //[manager writeData:@"Test data"];
    [self sendMessage];
}

- (void)sendMessage
{
    NSMutableDictionary *messageData = [[NSMutableDictionary alloc] init];
    [messageData setObject:contact.userid forKey:@"contact_id"];
    [messageData setObject:account.user_id forKey:@"user_id"];
    [messageData setObject:account.user_name forKey:@"user_name"];
    [messageData setObject:contact.username forKey:@"contact_name"];
    [messageData setObject:@"A simple test data" forKey:@"message"];

    [socketio emit:@"new_msg" args:@[messageData]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (MessageItemCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageItemCell *cell = [conversationView dequeueReusableCellWithIdentifier:@"messagecell"];
    Message *message = [messagelist objectAtIndex:indexPath.row];
    if(cell == nil) {
        cell = [[MessageItemCell alloc] init];
        cell.content.text = message.messageContent;
        cell.sender.text = message.senderName;
        if(message.senderName == account.user_id) {
            [cell setForUser];
            cell.sender.text = @"";
        } else {
            [cell setForContact];
            cell.sender.text = contact.username;
        }
    } else {
        cell.content.text = message.messageContent;
        cell.sender.text = message.senderName;
        if(message.senderName == account.user_id) {
            [cell setForUser];
        } else {
            [cell setForContact];
            cell.sender.text = contact.username;
        }
        
    }
    return cell;
}

- (void)dotDidReceivedChatMessages:(NSDictionary *)data
{
    NSLog(@"Reciving data from messaging api at MessageViewController");
    NSLog(@"Verifying data: %@", data);
    NSArray *incomingMessages = [data objectForKey:@"messages"];
    for(int i = 0; i < incomingMessages.count; i++) {
        NSDictionary *eachMessage = incomingMessages[i];
        NSString *content = [eachMessage objectForKey:@"content"];
        NSString *sender = [eachMessage objectForKey:@"sender"];
        Message *privateMessage = [[Message alloc] init];
        privateMessage.messageContent = content;
        privateMessage.senderName = sender;
        [messagelist addObject:privateMessage];
    }
    [conversationView reloadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return messagelist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
