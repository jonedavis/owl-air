//
//  AppDelegate.m
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "AppDelegate.h"
#import "TwilioHeader.h"
#import "FacebookStore.h"
#import "TwitterStore.h"
#import "UsersStore.h"
@import HockeySDK;

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
		// Instantiate Shared Manager
	[ReachabilityManager sharedManager];

    [[FacebookStore shared] handleApplication:application didFinishLaunchingWithOptions:launchOptions];
    [TwitterStore shared];
    // Configure and enable crashlytics
	[self enableCrashlytics];
	
    // Auto Login Functionality
//	[self setAutoLoggedIn];
/*Set firebase url initially*/
	[[NSUserDefaults standardUserDefaults] setObject:kFireBaseDev forKey:kFirebaseKey];

	[self customiseNavigationBar];
	
		//FIXME: Auto Logged In disabled
	[self disableAutoLogin];
	return YES;
}

-(void)disableAutoLogin{
		// Save Auto Logged In in UserDefaults
	NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
	
		//FIXME: Auto Logged In disabled
	[userdefaults setBool:NO forKey:kAUTOLOGGEDIN];
	
	[userdefaults synchronize];
}
#pragma mark - Crashlytics

-(void)enableCrashlytics{
		// Configure Crashlytics for distibuting Ad-Hoc build and keep track for Crashes while app is on Fly
    [Fabric with:@[[Crashlytics class]]];
}

#pragma mark - Auto Login

-(void)setAutoLoggedIn{
    if (!kFireBaseEndPoint) /*Set firebase url initially*/
        [[NSUserDefaults standardUserDefaults] setObject:kFireBaseSandbox forKey:kFirebaseKey];
    
		// Check if User has selected "Keep Me logged in"
	NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
	
		// Get auto login value
	BOOL isAutoLogggedIn = [userdefaults boolForKey:kAUTOLOGGEDIN];
	
	if (isAutoLogggedIn) {
			// If Enabled , Show Dashboard / Tabbar Menu
			// Navigate to Dashboard menu
		[self.window setRootViewController:[Utility getDashboardMenu]];
	}
	else{
			// If Disabled, show Log in Screen
		[self.window setRootViewController:[Utility getLoginControl]];
	}
}

-(void)customiseNavigationBar{
		// Navigation Bar Customisation
	[UINavigationBar appearance].translucent = false;
	[[UINavigationBar appearance] setBarTintColor:[Utility colorWithHexString:kNavigationColor]];
	[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
	
		// Status Bar Text Color change, prior to this select info.plist and check key-values pair for 'View controller-based status bar appearance' to NO/false
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
	
		// Navigation Bar Title Color change
	NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
											   [UIColor whiteColor],NSForegroundColorAttributeName,
											   [UIFont boldSystemFontOfSize:20],NSFontAttributeName, nil];
	
	[[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    [[FacebookStore shared] handleApplicationDidBecomeActive:application];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    [[UsersStore shared] enableUser:NO];
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[UsersStore shared] enableUser:YES];
//    [self.window setRootViewController:[Utility getLoginControl]]; //Any specific reason to use this?
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FacebookStore shared] handleOpenURL:url withSourceApplication:sourceApplication annotation:annotation];
}

@end
