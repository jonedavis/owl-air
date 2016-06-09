//
//  SliderControl.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "SliderControl.h"
#import "TwilioHeader.h"
#import "CommandUser.h"

@interface SliderControl ()<UITableViewDataSource,UITableViewDelegate>{
	NSArray *_tableContentArray,*_controllerArray;
}

@end

@implementation SliderControl

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self initializeValues];
}

-(void)initializeValues
{
		/* Set Values for List of Menus to be displayed on the Dashboard/Side Menu
		 */
#warning Customise or Set the list which has to be shown in the dashboard
	_tableContentArray = @[@"Travel",@"Logout"];
	
		// Storyboard Id for the controller which has to be shown on selecting the menu from dashboard
	_controllerArray = @[kTabBarControl,@""];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return _tableContentArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	NSString *cellIdentifier = [NSString stringWithFormat:@"Dashboard-%ld.%ld",(long)indexPath.section,(long)indexPath.row];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	
		// Create Cell is null
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		cell.selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
		cell.backgroundColor = [UIColor clearColor];
		cell.backgroundView.backgroundColor = [UIColor clearColor];
	}
	
		// set Cell Title
	cell.textLabel.text = _tableContentArray[indexPath.row];
	cell.textLabel.textColor = [UIColor whiteColor];
	return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	return 100;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	UIView *headerView = [UIView new];
	headerView.backgroundColor = [UIColor clearColor];
	return headerView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
		// Footer No Separator
	return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.row == _tableContentArray.count-1) {
        [CommandLogoutUser execute];
	}
	else{
        // This section is use to switch between the menu in the dashboard, Currently it has one menu item in '_controllerArray' i,e. TabBarControl based on situation demand it will change the list and fetch from the list accordingly
		[self.sideMenuViewController setContentViewController:[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:_controllerArray[indexPath.row]] animated:YES];
		[self.sideMenuViewController hideMenuViewController];
	}
}
@end
