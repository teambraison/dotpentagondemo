//
//  Account.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize session_id, user_id, user_name, password, isAuthenticated;

+ (Account *)sharedInstance
{
    static Account *_default = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _default = [[self alloc] init];
    });
    return _default;
}


@end
