//
//  DotAPI.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <Foundation/Foundation.h>

#define URL @"http://teambraison-dot.jit.su"
#define SOCKET_URL @"http://teambraison-dot.jit.su/socket.io/"
//#define URL @"http://localhost:3000"

//@protocol DotAPIDelegate
//
//- (void)dotDidReceivedData:(NSDictionary *)data;
//
//@end

@interface DotAPI : NSObject <NSURLConnectionDataDelegate>

//@property (weak) id <DotAPIDelegate> delegate;


@end


@protocol DotLoginDelegate

- (void)dotDidLogin:(NSDictionary *)data;

@end

@interface DotLoginAPI : DotAPI

- (void)requestLoginWith:(NSString *)username AndPassword:(NSString *)password;

@property (weak) id <DotLoginDelegate> delegate;


@end

@protocol DotDidReceivedChatMessages

- (void)dotDidReceivedChatMessages:(NSDictionary *)data;

@end

@interface DotRequestMessagesAPI : DotAPI

- (void)requestMessagesWith:(NSString *)senderid AndContact:(NSString *)contactid WithSession:(NSString *)sessionid;

@property (weak) id<DotDidReceivedChatMessages> delegate;

@end

@protocol DotRequestLatestMessageDelegate

- (void)dotDidReceivedLatestMessage:(NSDictionary *)data;

@end

@interface DotRequestLatestMessageAPI : DotAPI

- (void)requestLatestMessageWith:(NSString *)senderid AndContact:(NSString *)contactid;

@property (weak) id<DotRequestLatestMessageDelegate> delegate;

@end

@interface DotSendMessageAPI: DotAPI

- (void)sendMessageWithSession:(NSString *)sessionid AndSenderID:(NSString *)senderid AndReceiver:(NSString *)receiverid AndMessage:(NSString *)message;

@end




@protocol DotRequestAllUsersDelegate

- (void)dotDidReceiveAllUsers:(NSDictionary *)data;

@end

@interface DotRequestAllUsersAPI : DotAPI

- (void)requestAllUsers:(NSString *)sessionid;

@property (weak) id <DotRequestAllUsersDelegate> delegate;

@end
