//
//  DotViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "DotViewController.h"

@interface DotViewController ()
{
    BLEManager *bleManager;
}

@end

@implementation DotViewController

@synthesize statusLabel, alertView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    bleManager = [BLEManager sharedInstance];
    bleManager.delegate = self;
    alertView.hidden = true;
    
    UISwipeGestureRecognizer *settingGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(callSetting)];
    settingGesture.direction = UISwipeGestureRecognizerDirectionDown;
    settingGesture.numberOfTouchesRequired = 2;
    
    [self.view addGestureRecognizer:settingGesture];
    // Do any additional setup after loading the view.
}

 - (void)bleDidConnectWithDevice
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}

- (void)callSetting
{
    [bleManager startScan];
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
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
