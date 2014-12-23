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

#define ERIC_ICON @"eric_icon.png"
#define KI_ICON @"ki_icon.png"
#define MASON_ICON @"mason_icon.png"
#define JASON_ICON @"jason_icon.png"

@interface ContactViewController ()
{
    NSMutableArray *contactlist;
    Account *account;
    DotRequestAllUsersAPI *userRequestAPI;
    BOOL didRequestAllUsers;
}

@end

@implementation ContactViewController

@synthesize contactsmenu;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    account = [Account sharedInstance];
    
    [self.contactsmenu registerNib:[UINib nibWithNibName:@"ContactItemCell" bundle:nil] forCellReuseIdentifier:@"contactcell"];
    
    userRequestAPI = [[DotRequestAllUsersAPI alloc] init];
    userRequestAPI.delegate = self;
    
    contactlist = [[NSMutableArray alloc] init];
    contactsmenu.delegate = self;
    contactsmenu.dataSource = self;
    
    didRequestAllUsers = false;
    
    [self checkAuthentication];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{

}

- (void)viewDidAppear:(BOOL)animated
{
    [self checkAuthentication];
}

- (void)checkAuthentication
{
    if(!account.isAuthenticated) {
        LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"login"];
        [self presentViewController:loginVC animated:true completion:nil];
    } else {
        [self.navigationController setNavigationBarHidden:false];
        self.navigationItem.title = @"Contacts";
        if(!didRequestAllUsers) {
            [userRequestAPI requestAllUsers:account.session_id];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(contactlist.count > 0 && contactlist.count > indexPath.row) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MessageViewController *messageVC = [storyboard instantiateViewControllerWithIdentifier:@"messages"];
        [messageVC setContact:[contactlist objectAtIndex:indexPath.row]];
        [self.navigationController pushViewController:messageVC animated:true];
    }
 //   [self presentViewController:messageVC animated:true completion:nil];
}

- (void)dotDidReceiveAllUsers:(NSDictionary *)data
{
    if(data != nil) {
        NSLog(@"Reciving data from delegate at ContactViewController");
        NSLog(@"Verifying data: %@", data);
        NSArray *incomingData = [data objectForKey:@"contacts"];
        for(int i = 0; i < incomingData.count; i++) {
            NSDictionary *thisContact = [incomingData objectAtIndex:i];
            NSString *username = [thisContact objectForKey:@"username"];
            NSString *userid = [thisContact objectForKey:@"userid"];
            NSString *name = [thisContact objectForKey:@"name"];
            Contact *newContact = [[Contact alloc] init];
            newContact.username = username;
            newContact.userid = userid;
            newContact.name = name;
            [contactlist addObject:newContact];
            NSLog(@"Contact name '%@' with id: '%@' and name '%@' ", username, userid, name);
            
        }
        [self.contactsmenu reloadData];
        didRequestAllUsers = true;
    } else {
    //    [userRequestAPI requestAllUsers:account.session_id];
    }
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
    Contact *myContact = [contactlist objectAtIndex:indexPath.row];
    if(cell == nil) {
        cell = [[ContactItemCell alloc] init];
    }
    cell.contactName.text = myContact.name;
    if([myContact.username isEqualToString:@"eric"]) {
        cell.contactImage.image = [UIImage imageNamed:ERIC_ICON];
    }
    if([myContact.username isEqualToString:@"jason"]) {
        cell.contactImage.image = [UIImage imageNamed:JASON_ICON];
    }
    if([myContact.username isEqualToString:@"mason"]) {
        cell.contactImage.image = [UIImage imageNamed:MASON_ICON];
    }
    if([myContact.username isEqualToString:@"ki"]) {
        cell.contactImage.image = [UIImage imageNamed:KI_ICON];
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
