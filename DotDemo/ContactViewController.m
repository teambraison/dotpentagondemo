//
//  ContactViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "ContactViewController.h"

#define AUTO_AUTHENICATION_USERNAME @"eric"
#define AUTO_AUTHENTICATION_PASSWORD @"6891"

@interface ContactViewController ()
{
    NSMutableArray *contactlist;
    Account *account;
    DotLoginAPI *loginAPI;
    DotRequestAllUsersAPI *userRequestAPI;
}

@end

@implementation ContactViewController

@synthesize contactsmenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    loginAPI = [[DotLoginAPI alloc] init];
    loginAPI.delegate = self;
    
    [self.contactsmenu registerNib:[UINib nibWithNibName:@"ContactItemCell" bundle:nil] forCellReuseIdentifier:@"contactcell"];
    
    userRequestAPI = [[DotRequestAllUsersAPI alloc] init];
    userRequestAPI.delegate = self;
    
    contactlist = [[NSMutableArray alloc] init];
    contactsmenu.delegate = self;
    contactsmenu.dataSource = self;
    
    [self checkAuthentication];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)checkAuthentication
{
    account = [Account sharedInstance];
    if(account == nil) {
        NSLog(@"account is nil at authentication");
    } else {
        NSLog(@"Account is not nil at authentication");
    }
    if(!account.isAuthenticated) {
        [loginAPI requestLoginWith:AUTO_AUTHENICATION_USERNAME AndPassword:AUTO_AUTHENTICATION_PASSWORD];
    } else {
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MessageViewController *messageVC = [storyboard instantiateViewControllerWithIdentifier:@"messages"];
    [messageVC setContact:[contactlist objectAtIndex:indexPath.row]];
    [self presentViewController:messageVC animated:true completion:nil];
}

- (void)dotDidLogin:(NSDictionary *)data
{
    NSLog(@"Reciving data from login api at ContactViewController");
    NSLog(@"Verifying data: %@", data);
    if(data != nil) {
        NSString *userid = [data objectForKey:@"user_id"];
        NSString *sessionid = [data objectForKey:@"user_sessionid"];
        account.user_id = [NSString stringWithString:userid];
        account.session_id = [NSString stringWithString:sessionid];
        account.isAuthenticated = true;
        account.user_name = AUTO_AUTHENICATION_USERNAME;
        [userRequestAPI requestAllUsers:sessionid];

        NSLog(@"Login data is intact");
    } else {
        NSLog(@"Login data is null");
    }
    
    NSLog(@"Login Account username: %@", account.user_name);
}


- (void)dotDidReceiveAllUsers:(NSDictionary *)data
{
    NSLog(@"Reciving data from delegate at ContactViewController");
    NSLog(@"Verifying data: %@", data);
    NSArray *incomingData = [data objectForKey:@"contacts"];
    for(int i = 0; i < incomingData.count; i++) {
        NSDictionary *thisContact = [incomingData objectAtIndex:i];
        NSString *name = [thisContact objectForKey:@"username"];
        NSString *userid = [thisContact objectForKey:@"userid"];
        Contact *newContact = [[Contact alloc] init];
        newContact.username = name;
        newContact.userid = userid;
        [contactlist addObject:newContact];
        NSLog(@"Contact name: %@ id: %@", name, userid);
        
    }
    [self.contactsmenu reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (ContactItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactItemCell *cell = [contactsmenu dequeueReusableCellWithIdentifier:@"contactcell"];
    [[[cell messageCount] layer] setCornerRadius:25.0f];
    [[[cell messageCount] layer] setMasksToBounds:YES];
    if(cell == nil) {
        cell = [[ContactItemCell alloc] init];
        Contact *myContact = [contactlist objectAtIndex:indexPath.row];
        cell.contactName.text = myContact.username;
    } else {
        Contact *myContact = [contactlist objectAtIndex:indexPath.row];
        cell.contactName.text = myContact.username;
    }
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contactlist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
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
