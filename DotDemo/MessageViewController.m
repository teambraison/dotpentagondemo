//
//  MessageViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MessageViewController.h"

#define MESSAGE_KEY @"message"

@interface MessageViewController ()
{
    NSMutableArray *messagelist;
    DotRequestMessagesAPI *messagesAPI;
    DotRequestLatestMessageAPI *latestMessageAPI;
    DotSendMessageAPI *sendMessageAPI;
    Account *account;
    Contact *contact;
    SIOSocket *socketio;
    KeyboardViewController *keyboardVC;
}

@end

@implementation MessageViewController

@synthesize conversationView, messageTextView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    manager = [BLEManager sharedInstance];
    manager.delegate = self;
    [manager startScan];
    conversationView.delegate = self;
    conversationView.dataSource = self;
    
    
    [self.conversationView registerNib:[UINib nibWithNibName:@"MessageItemCell" bundle:nil] forCellReuseIdentifier:@"messagecell"];
    
    if(contact != nil) {
        [self.navigationController setNavigationBarHidden:false];
        self.navigationItem.title = contact.username;
    }
    
    account = [Account sharedInstance];
    
    messagesAPI = [[DotRequestMessagesAPI alloc] init];
    messagesAPI.delegate = self;
    
    sendMessageAPI = [[DotSendMessageAPI alloc] init];
    
    latestMessageAPI = [[DotRequestLatestMessageAPI alloc] init];
    latestMessageAPI.delegate = self;
    
    
    messagelist = [[NSMutableArray alloc] init];
    
    [SIOSocket socketWithHost:URL  response: ^(SIOSocket *socket) {
        self->socketio = socket;
    }];
    
    [messagesAPI requestMessagesWith:account.user_id AndContact:contact.userid WithSession:account.session_id];
    
    keyboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"keyboard"];
    keyboardVC.delegate = self;
    
    UITapGestureRecognizer *keyboardTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openKeyboard)];
    keyboardTap.numberOfTapsRequired = 1;
    keyboardTap.numberOfTouchesRequired = 1;
    [messageTextView addGestureRecognizer:keyboardTap];
    
    UISwipeGestureRecognizer *swipeSendMessage = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(sendMessage)];
    swipeSendMessage.direction = UISwipeGestureRecognizerDirectionRight;
    swipeSendMessage.numberOfTouchesRequired = 1;
    [messageTextView addGestureRecognizer:swipeSendMessage];
    
    UISwipeGestureRecognizer *connectBluetooth = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(connectWithBlE)];
    connectBluetooth.numberOfTouchesRequired = 2;
    connectBluetooth.direction = UISwipeGestureRecognizerDirectionDown;
    [self.view addGestureRecognizer:connectBluetooth];
    
}

- (void)bleDidConnectWithDevice
{
     AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)connectWithBlE
{
    [manager startScan];
}

- (void)viewDidAppear:(BOOL)animated
{
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    [userData setObject:account.user_name forKey:@"user_name"];
    [userData setObject:account.user_id forKey:@"user_id"];
    [socketio emit:@"join" args:@[userData]];
    
    [socketio on:@"new_msg" callback:^(NSArray *args) {
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(args.count > 0) {
                NSDictionary *receivedMessage = [args objectAtIndex:0];
                Message *newMessage = [[Message alloc] init];
                newMessage.senderName = [receivedMessage objectForKey:@"sender_id"];
                newMessage.messageContent = [receivedMessage objectForKey:@"message"];
                [messagelist addObject:newMessage];
                [manager writeData:@"각"];
                [conversationView reloadData];
                [conversationView layoutIfNeeded];
                NSLog(@"%@", args);
                [self scrollToBottom];
            }
        });
    }];

}

- (void)scrollToBottom
{
    [conversationView setContentOffset:CGPointMake(0, conversationView.contentSize.height-conversationView.frame.size.height) animated:YES];
}

- (void)keyboardViewDidFinishInput:(NSString *)value WithKey:(NSString *)key
{
    if([key isEqualToString:MESSAGE_KEY]) {
        messageTextView.text = value;
    }
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

- (void)openKeyboard
{
    keyboardVC.key = MESSAGE_KEY;
    [self presentViewController:keyboardVC animated:true completion:nil];
}


- (void)setContact:(Contact *)theContact
{
    contact = theContact;
}
- (IBAction)sendMessageButtonPressed:(id)sender {
    [self sendMessage];
}

- (void)sendMessage
{
    NSLog(@"sending message");
    //First join
    
    //Then send message
    if(messageTextView.text != nil) {
        NSMutableDictionary *messageData = [[NSMutableDictionary alloc] init];
        [messageData setObject:contact.userid forKey:@"contact_id"];
        [messageData setObject:account.user_id forKey:@"user_id"];
        [messageData setObject:account.user_name forKey:@"user_name"];
        [messageData setObject:contact.username forKey:@"contact_name"];
        [messageData setObject:messageTextView.text forKey:@"message"];
        
        Message *mySendMessage = [[Message alloc] init];
        mySendMessage.senderName = account.user_name;
        mySendMessage.messageContent = messageTextView.text;
        [messagelist addObject:mySendMessage];
        [conversationView reloadData];
        [self scrollToBottom];
        
        [messageTextView resignFirstResponder];

        [socketio emit:@"new_msg" args:@[messageData]];
    }
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
    [self scrollToBottom];

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
