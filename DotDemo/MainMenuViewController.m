//
//  MainMenuViewController.m
//  DotDemo
//
//  Created by Titus Cheng on 12/11/14.
//  Copyright (c) 2014 Braison. All rights reserved.
//

#import "MainMenuViewController.h"

#define SECTION ["dssfds", @""]
#define MENU [NSArray arrayWithObjects:@"BUS", @"MESSAGE", @"TIME", @"SETTINGS", nil]
#define MENU_ICON [NSArray arrayWithObjects: @"bus_icon", @"msg_icon", @"time_icon", @"settings_icon", nil]
#define MENU_DESC [NSArray arrayWithObjects: @"버스를 찾아보세요", @"친구에게 메시지를 보내세요", @"시간을 보고 알람을 맞추세요", @"설정을 변경할 수 있습니다", nil]

#define ITEM_COUNT 4


@implementation MainMenuViewController

@synthesize mainMenu;

- (void)viewDidLoad
{
    manager = [BLEManager sharedInstance];
    [self.mainMenu registerNib:[UINib nibWithNibName:@"MainMenuTableViewCell" bundle:nil] forCellReuseIdentifier:@"menucell"];
    mainMenu.delegate = self;
    mainMenu.dataSource = self;
    [mainMenu reloadData];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [manager startScan];
}

- (MainMenuTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MainMenuTableViewCell *cell = [mainMenu dequeueReusableCellWithIdentifier:@"menucell"];
    if(cell == nil) {
        cell = [[MainMenuTableViewCell alloc] init];
        cell.menuName.text = [MENU objectAtIndex:indexPath.row];
        [cell.menuIcon setImage:[UIImage imageNamed:[MENU_ICON objectAtIndex:indexPath.row]]];
        cell.menuDescription.text = [MENU_DESC objectAtIndex:indexPath.row];
        
    } else {
        cell.menuName.text = [MENU objectAtIndex:indexPath.row];
        [cell.menuIcon setImage:[UIImage imageNamed:[MENU_ICON objectAtIndex:indexPath.row]]];
        cell.menuDescription.text = [MENU_DESC objectAtIndex:indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ContactViewController *contactVC = [storyboard instantiateViewControllerWithIdentifier:@"contacts"];
        [self presentViewController:contactVC animated:true completion:nil];
    } else if(indexPath.row == 3) {
        [manager startScan];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ITEM_COUNT;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

@end