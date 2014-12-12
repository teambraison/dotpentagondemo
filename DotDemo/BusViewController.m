//
//  BusViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/12/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "BusViewController.h"

#define BUS_NUMBER [NSArray arrayWithObjects:@"5000", @"2323", @"5009", @"3434", nil]
#define TIME_FRAME [NSArray arrayWithObjects:@"5", @"294", @"608", @"890", nil]


@interface BusViewController ()
{
    NSMutableArray *buslist;
    NSArray *waitTime;
    BOOL didVibrate;
    BLEManager *manager;
}

@end

@implementation BusViewController
@synthesize busTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    buslist = [[NSMutableArray alloc] init];
    busTableView.delegate = self;
    busTableView.dataSource = self;
    [self.busTableView registerNib:[UINib nibWithNibName:@"BusItemView" bundle:nil] forCellReuseIdentifier:@"busitemcell"];
    [self.busTableView reloadData];
    
    didVibrate = false;
    manager = [BLEManager sharedInstance];
    manager.delegate = self;
    [manager startScan];
    
    NSTimer *timer = [[NSTimer alloc] initWithFireDate:[NSDate date] interval:1 target:self selector:@selector(updateAllBus) userInfo:nil repeats:true];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    // Do any additional setup after loading the view.
}

- (void)updateAllBus
{
    for(int i = 0; i < TIME_FRAME.count; i++) {
        BusItemView *busitem = [buslist objectAtIndex:i];
        if(busitem.time == 0) {
            if(!didVibrate){
                AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                didVibrate = true;
                [manager writeData:@"5000"];
            }
        } else {
            busitem.time--;
        }
        busitem.waittime.text = [self convertSecondsToWaitTime:[NSString stringWithFormat:@"%ld", (long)busitem.time]];
        
        
    }
  //  busitem.waittime.text =
}

- (void)bleDidConnectWithDevice
{
    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}



- (NSString *)convertSecondsToWaitTime:(NSString *)theTime
{
    NSString *myWaitTime = @"00:00:00";
    if([theTime integerValue] < 60)
    {
   //     NSLog(@"time: 00:00:%@", [self maskTime:theTime]);
        return [NSString stringWithFormat:@"00:00:%@", [self maskTime:theTime]];
    } else if([theTime integerValue] < 3600) {
        NSInteger minutes = [theTime integerValue] / 60;
        NSInteger seconds = [theTime integerValue] % 60;
        NSString *minuteString = [self maskTime:[NSString stringWithFormat:@"%ld", (long)minutes]];
        NSString *secondString = [self maskTime:[NSString stringWithFormat:@"%ld", (long)seconds]];
        return [NSString stringWithFormat:@"00:%@:%@", minuteString, secondString];
    } else{
        NSInteger hours = [theTime integerValue] / 3600;
        NSInteger minutes = [theTime integerValue] / 60;
        NSInteger seconds = [theTime integerValue] % 60;
        NSString *hourString = [self maskTime:[NSString stringWithFormat:@"%ld", (long)hours]];
        NSString *minuteString = [self maskTime:[NSString stringWithFormat:@"%ld", (long)minutes]];
        NSString *secondString = [self maskTime:[NSString stringWithFormat:@"%ld", (long)seconds]];
        return [NSString stringWithFormat:@"%@:%@:%@", hourString, minuteString, secondString];
    }
    return myWaitTime;
}

- (NSString *)maskTime:(NSString *)timeFrame
{
    
    if([timeFrame integerValue] <= 9) {
        return [NSString stringWithFormat:@"0%@", timeFrame];
    } else {
        return [NSString stringWithFormat:@"%@", timeFrame];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BusItemView *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BusItemView *cell = [busTableView dequeueReusableCellWithIdentifier:@"busitemcell"];
    if(cell == nil) {
        cell = [[BusItemView alloc] init];
        cell.busnumber.text = [BUS_NUMBER objectAtIndex:indexPath.row];
        cell.waittime.text = [self convertSecondsToWaitTime:[TIME_FRAME objectAtIndex:indexPath.row]];
        cell.time = [[TIME_FRAME objectAtIndex:indexPath.row] integerValue];
    } else {
        cell.busnumber.text = [BUS_NUMBER objectAtIndex:indexPath.row];
        cell.waittime.text = [self convertSecondsToWaitTime:[TIME_FRAME objectAtIndex:indexPath.row]];
        cell.time = [[TIME_FRAME objectAtIndex:indexPath.row] integerValue];
    }
    [buslist addObject:cell];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [manager writeData:@"more testing data"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 74;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return BUS_NUMBER.count;
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
