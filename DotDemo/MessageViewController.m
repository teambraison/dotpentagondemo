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
    Account *account;
    Contact *contact;
}

@end

@implementation MessageViewController

@synthesize contactName, messageLabel, conversationView, socketio;

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    
    messagelist = [[NSMutableArray alloc] init];
    
    socketio = [[SocketIO alloc] initWithDelegate:self];
    [socketio connectToHost:@"teambraison-dot.jit.su/socket.io/" onPort:80];
    
    [messagesAPI requestMessagesWith:account.user_id AndContact:contact.userid WithSession:account.session_id];
    
//    [SIOSocket socketWithHost:@"http://teambraison-dot.jit.su/socket.io/" reconnectAutomatically:true attemptLimit:1 withDelay:5 maximumDelay:30 timeout:30 response:^(SIOSocket *socket){
//        socketio = socket;
//    }];
//    
//    
//    [socketio emit:@"join" args:[NSArray arrayWithObject:userData]];
//    [socketio on:@"new_msg" callback:^(NSArray *args){
//        NSLog(@"Incoming message %@", args);
//    }];
    // Do any additional setup after loading the view.
}

- (void)socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"Socket IO did disconnect");
    [socketio connectToHost:@"teambraison-dot.jit.su/socket.io/" onPort:80];
}

- (void)socketIO:(SocketIO *)socket didSendMessage:(SocketIOPacket *)packet
{
    NSLog(@"Socket IO successfully send message");
}

- (void)socketIO:(SocketIO *)socket onError:(NSError *)error
{
    if(error != nil) {
        NSLog(@"Error in socket: %@ %@", error.debugDescription, error.description);
    }
}

- (void)socketIO:(SocketIO *)socket didReceiveJSON:(SocketIOPacket *)packet
{
    NSLog(@"Socket IO did receive JSON packet");
}

- (void)socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"Packet data: %@", packet.data);
    NSLog(@"Packet desc: %@", packet.description);
    NSLog(@"Packet name: %@", packet.name);
    
}

- (void)socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"Successfully connected to socket");
    
    NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
    [userData setObject:account.user_name forKey:@"user_name"];
    [userData setObject:account.user_id forKey:@"user_id"];
    [socket sendEvent:@"join" withData:userData andAcknowledge:^(id data){
        NSLog(@"Successfully joined");
    }];
}


- (void)setContact:(Contact *)theContact
{
    contact = theContact;
}
- (IBAction)sendMessageButtonPressed:(id)sender {
    NSMutableDictionary *messageData = [[NSMutableDictionary alloc] init];
    [messageData setObject:account.user_id forKey:@"user_id"];
    [messageData setObject:@"A simple test data" forKey:@"message"];
    [socketio sendEvent:@"new_msg" withData:messageData andAcknowledge:^(id argsdata){
        NSLog(@"Successfully send data");
    }];
    [manager writeData:@"Test data"];
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
