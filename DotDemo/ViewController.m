//
//  ViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "ViewController.h"
#import "BLEManager.h"

@interface ViewController ()
{
    BLEManager *manager;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"First view controller did loaded");
    manager = [[BLEManager alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)connectToBluetooth:(id)sender {
    [manager startScan];
}
- (IBAction)sentMessage:(id)sender {
    [manager writeData:@"A test to see"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
