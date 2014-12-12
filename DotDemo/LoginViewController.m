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

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize usernameDisplay, usernameSelection, passwordDisplay, passwordSelection;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)loginClicked:(id)sender {
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
