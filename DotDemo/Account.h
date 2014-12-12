//
//  Account.h
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject


+ (Account *)sharedInstance;

@property (nonatomic, strong) NSString *session_id;
@property (nonatomic, strong) NSString *user_name;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString * user_id;
@property (nonatomic, assign) BOOL isAuthenticated;

@end
