//
//  TimeViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/16/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "TimeViewController.h"

#define ALARM [NSArray arrayWithObjects:@"2:30", @"12:30", @"9:44", @"8:30", nil]
#define TIME_DIFF [NSArray arrayWithObjects:@"오후", @"오전", @"오후", @"오후", @"오후", nil]
#define DAYS [NSArray arrayWithObjects:@"일. 월. 토", @"일. 월. 화", @"일", @"일", nil]

@interface TimeViewController ()

@end

@implementation TimeViewController

@synthesize alarmTableView, mainTimeView,timeIndicatorLabel, timeLabel, currentTimeContainer;

- (void)viewDidLoad {
    [super viewDidLoad];
    [alarmTableView registerNib:[UINib nibWithNibName:@"AlarmItemCell" bundle:nil] forCellReuseIdentifier:@"alarmitemcell"];
    
    mainTimeView.layer.cornerRadius = 60.0f;
    mainTimeView.layer.masksToBounds = true;
    
    currentTimeContainer.layer.cornerRadius = 6.0f;
    currentTimeContainer.layer.masksToBounds = true;
    
    alarmTableView.delegate = self;
    alarmTableView.dataSource = self;
    [alarmTableView reloadData];
    // Do any additional setup after loading the view.
}

- (AlarmItemCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AlarmItemCell *cell = [alarmTableView dequeueReusableCellWithIdentifier:@"alarmitemcell"];
    if(cell == nil) {
        cell = [[AlarmItemCell alloc] init];
    }
    cell.alarmTime.text = [ALARM objectAtIndex:indexPath.row];
    cell.amPmLabel.text = [TIME_DIFF objectAtIndex:indexPath.row];
    cell.daysLabel.text = [DAYS objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ALARM.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 73.0f;
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
