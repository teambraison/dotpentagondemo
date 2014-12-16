//
//  DotAPI.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "DotAPI.h"

//#define URL @"http://teambraison-dot.jit.su"
#define URL @"http://localhost:3000"

@implementation DotAPI

- (id)init
{
    self = [super init];
    if(self) {
        
    }
    return self;
}

- (void)startRequest:(NSString *)relativeURL WithData:(NSDictionary *)parameters
{
    
    NSString *url_str = [NSString stringWithFormat:@"%@%@", URL, relativeURL];
    
    NSLog(@"Start requesting api %@", url_str);
//    NSMutableDictionary *vars = [NSMutableDictionary new];
//    [vars setObject:@"value1" forKey:@"key1"];
//    [vars setObject:@"value2" forKey:@"key2"];
    
    [self send_url_encoded_http_post_request:url_str vars:parameters];
}

- (void)requestLoginWith:(NSString *)username AndPassword:(NSString *)password
{
    NSLog(@"Requesting login with %@ and %@", username, password);
    NSString *api = @"/api/login";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:username forKey:@"user"];
    [parameters setObject:password forKey:@"pass"];
    
    [self startRequest:api WithData:parameters];
}


- (NSString *)urlencode:(NSString *)input {
    const char *input_c = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSMutableString *result = [NSMutableString new];
    for (NSInteger i = 0, len = strlen(input_c); i < len; i++) {
        unsigned char c = input_c[i];
        if (
            (c >= '0' && c <= '9')
            || (c >= 'A' && c <= 'Z')
            || (c >= 'a' && c <= 'z')
            || c == '-' || c == '.' || c == '_' || c == '~'
            ) {
            [result appendFormat:@"%c", c];
        }
        else {
            [result appendFormat:@"%%%02X", c];
        }
    }
    return result;
}

- (void)send_url_encoded_http_post_request:(NSString *)url_str vars:(NSDictionary *)vars {
    NSMutableString *vars_str = [NSMutableString new];
    if (vars != nil && vars.count > 0) {
        BOOL first = YES;
        for (NSString *key in vars) {
            if (!first) {
                [vars_str appendString:@"&"];
            }
            first = NO;
            
            [vars_str appendString:[self urlencode:key]];
            [vars_str appendString:@"="];
            [vars_str appendString:[self urlencode:[vars valueForKey:key]]];
        }
    }
    
    NSURL *url = [NSURL URLWithString:url_str];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPShouldHandleCookies:NO];
    [request setValue:@"Agent name goes here" forHTTPHeaderField:@"User-Agent"];
    [request setHTTPBody:[vars_str dataUsingEncoding:NSUTF8StringEncoding]];
    [NSURLConnection connectionWithRequest:request delegate:self];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receiving data from connection");
//    [delegate dotDidReceivedData:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
}

@end


@implementation DotLoginAPI

@synthesize delegate;

- (void)requestLoginWith:(NSString *)username AndPassword:(NSString *)password
{
//    NSLog(@"Requesting login with %@ and %@", username, password);
    NSString *api = @"/api/login";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:username forKey:@"user"];
    [parameters setObject:password forKey:@"pass"];
    
    [self startRequest:api WithData:parameters];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(data != nil) {
        NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        NSString *lastChar = [dataString substringFromIndex:[dataString length] - 1];
        NSDictionary *jsonData;
        if([lastChar isEqualToString:@"}"]) {
            jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"Login username: %@, session id: %@", [jsonData objectForKey:@"user_id"], [jsonData objectForKey:@"user_sessionid"]);
        } else {
            NSString *loginString = [[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding] stringByAppendingString:@"}"];
            jsonData = [NSJSONSerialization JSONObjectWithData:[loginString dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:nil];
//            NSLog(@"Login username: %@, session id: %@", [jsonData objectForKey:@"user_id"], [jsonData objectForKey:@"user_sessionid"]);

        }
        
        [delegate dotDidLogin:jsonData];
    }
}

@end

@implementation DotRequestAllUsersAPI

@synthesize delegate;

- (void)requestAllUsers:(NSString *)sessionid
{
    NSLog(@"Requesting all users with session id %@", sessionid);
    NSString *api = @"/api/allusers";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:sessionid forKey:@"session_id"];
    
    [self startRequest:api WithData:parameters];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receiving data from connection");
    NSString *dataString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Receiving data %@", dataString);
    [delegate dotDidReceiveAllUsers:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
}

@end


@implementation DotRequestMessagesAPI

@synthesize delegate;

- (void)requestMessagesWith:(NSString *)senderid AndContact:(NSString *)contactid WithSession:(NSString *)sessionid
{
    NSLog(@"Requesting all messages from %@", senderid);
    NSString *api = @"/api/message/get";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:sessionid forKey:@"session_id"];
    [parameters setObject:senderid forKey:@"user_id"];
    [parameters setObject:contactid forKey:@"contact_id"];
    
    [self startRequest:api WithData:parameters];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receiving data from connection");
    [delegate dotDidReceivedChatMessages:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
}

@end

@implementation DotRequestLatestMessageAPI

@synthesize delegate;

- (void)requestLatestMessageWith:(NSString *)senderid AndContact:(NSString *)contactid
{
    NSLog(@"Requesting latest message from %@", senderid);
    NSString *api = @"/api/message/latest";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
 //   [parameters setObject:sessionid forKey:@"session_id"];
    [parameters setObject:senderid forKey:@"user_id"];
    [parameters setObject:contactid forKey:@"contact_id"];
    
    [self startRequest:api WithData:parameters];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"Receiving data from latest message connection");
    [delegate dotDidReceivedLatestMessage:[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil]];
    
}

@end

@implementation DotSendMessageAPI


- (void)sendMessageWithSession:(NSString *)sessionid AndSenderID:(NSString *)senderid AndReceiver:(NSString *)receiverid AndMessage:(NSString *)message
{
    NSString *api = @"/api/message/send";
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    //   [parameters setObject:sessionid forKey:@"session_id"];
    [parameters setObject:sessionid forKey:@"session_id"];
    [parameters setObject:senderid forKey:@"sender_id"];
    [parameters setObject:receiverid forKey:@"receiver_id"];
    [parameters setObject:message forKey:@"message"];
    [self startRequest:api WithData:parameters];
    
    
}

@end



