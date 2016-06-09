//
//  TravelTabControl.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "TravelTabControl.h"
#import "TwilioHeader.h"

@interface TravelTabControl ()

@end

@implementation TravelTabControl

- (void)viewDidLoad {
    [super viewDidLoad];
	
		// Updated tab bar visuals
	[self customiseTabbarAppearance];
}


-(void)customiseTabbarAppearance{
		// Change the color for Tabbar visuals
	[[self tabBar] setTintColor:[Utility colorWithHexString:kAppRedColor]];
	[[self tabBar] setBarTintColor:[UIColor whiteColor]];
	
	[UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateNormal];
	[UITabBarItem.appearance setTitleTextAttributes:@{NSForegroundColorAttributeName : [Utility colorWithHexString:kAppRedColor]} forState:UIControlStateSelected];
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
