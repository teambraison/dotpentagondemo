//
//  LoginViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "LoginViewController.h"

#define USERNAME @"titus"
#define PASSWORD @"6891"

#define USERNAME_KEY  @"username"
#define PASSWORD_KEY  @"password"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    KeyboardViewController *keyboardVC;
    Account *account;
    NSString *username;
    NSString *password;
    DotLoginAPI *loginAPI;
}

@synthesize usernameDisplay, usernameSelection, passwordDisplay, passwordSelection, loginButton, loginView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    loginAPI = [[DotLoginAPI alloc] init];
    loginAPI.delegate = self;
    
    loginView.layer.cornerRadius = 6.0f;
    loginView.layer.masksToBounds = true;
    
    loginButton.layer.cornerRadius = 6.0f;
    loginButton.layer.cornerRadius = 6.0f;
    account = [Account sharedInstance];
    
    UITapGestureRecognizer *usernameTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputUserName)];
    usernameTap.numberOfTouchesRequired = 1;
    usernameTap.numberOfTapsRequired = 1;
    
    UITapGestureRecognizer *passwordTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(inputPassword)];
    passwordTap.numberOfTapsRequired = 1;
    passwordTap.numberOfTouchesRequired = 1;
    
    keyboardVC = [self.storyboard instantiateViewControllerWithIdentifier:@"keyboard"];
    keyboardVC.delegate = self;
    
    UISwipeGestureRecognizer *returnSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(returnToPreviousScreen)];
    
    [usernameSelection addGestureRecognizer:usernameTap];
    [passwordSelection addGestureRecognizer:passwordTap];
    [self.view addGestureRecognizer:returnSwipe];
    // Do any additional setup after loading the view.
}

- (void)returnToPreviousScreen
{
    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)dotDidLogin:(NSDictionary *)data
{
    NSLog(@"Reciving data from login api at LoginViewController");
    NSLog(@"Verifying data: %@", data);
    if(data != nil) {

        account.user_id = [data objectForKey:@"user_id"];
        account.session_id = [data objectForKey:@"user_sessionid"];
        account.isAuthenticated = true;
        account.user_name = usernameDisplay.text;
        [self dismissViewControllerAnimated:true completion:nil];
        
    } else {
        NSLog(@"Login data is null");
    }
    
    NSLog(@"Login Account username: %@", account.user_name);

}

- (void)keyboardViewDidFinishInput:(NSString *)value WithKey:(NSString *)key
{
    if([key isEqualToString:USERNAME_KEY]) {
        usernameDisplay.text = value;
        username = value;
    }
    if([key isEqualToString:PASSWORD_KEY]) {
        passwordDisplay.text = [self textToAsterisk:value];
        password = value;
    }
}

- (NSString *)textToAsterisk:(NSString *)text
{
    NSMutableString *passcode = [[NSMutableString alloc] init];
    for(int i = 0; i < text.length; i++) {
        [passcode appendString:@"*"];
    }
    return passcode;
}

- (void)inputUserName
{
    NSLog(@"input user name");
    keyboardVC.key = USERNAME_KEY;
    [self presentViewController:keyboardVC animated:true completion:nil];
}

- (void)inputPassword
{
    keyboardVC.key = PASSWORD_KEY;
    [self presentViewController:keyboardVC animated:true completion:nil];
    
}


- (IBAction)loginClicked:(id)sender {
    if(username != nil && password != nil) {
        [loginAPI requestLoginWith:username AndPassword:password];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
