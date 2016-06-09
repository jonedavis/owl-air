//
//  MyTripsControl.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "MyTripsControl.h"
#import "TwilioHeader.h"
@interface MyTripsControl ()<TripsTableDelegate,UpdateTripDetailsDelegate>
{
	IBOutlet TripsTableView *_tripsTableView;
	
	Trip *_selectedTripObj;
	IBOutlet UIButton *_statusButton;
	IBOutlet UILabel *_greetingLabel;
	BOOL isConnected,isUserOnline,isWebActive;
}
@end

@implementation MyTripsControl

- (void)viewDidLoad {
    [super viewDidLoad];
	
		// Change Navigation Bar Appearance
	[self customiseNavigationBar];
	
		// customising status indicator
	[self customiseStatusIndicator];
	
		// Set delegates for TableView
	[self setListTableDelegate];
	
		// set greeting
	[self setGreetingText];
	
		// veirfying user connection for internet is aviable or not
	[self checkNetworkConnection];
		// setting status indicator based on User connectivity & internet connection
	[self checkUserConnectivity];
	[self checkWebConnectivity];
}

-(void)checkNetworkConnection{
	if ([[ReachabilityManager sharedManager].reachability isReachable]) {
		isConnected = YES;
	} else {
		isConnected = NO;
	}
	[self setStatusIndicator];

		// enable notificaiton for network change
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityDidChange:) name:kReachabilityChangedNotification object:nil];
}

#pragma mark -
#pragma mark Notification Handling
- (void)reachabilityDidChange:(NSNotification *)notification {
	Reachability *reachability = (Reachability *)[notification object];
	
	if ([reachability isReachable]) {
		NSLog(@"Reachable");
		isConnected = YES;
	} else {
		NSLog(@"Unreachable");
		isConnected = NO;
	}
	[self setStatusIndicator];
}

#pragma mark - Status Indicator
-(void)checkUserConnectivity{
		// hit firebase to check wheather user is online or not
	[[UsersStore shared] getUserStatusWithCompletion:^(BOOL isOnline) {
		isUserOnline = isOnline;
		[self setStatusIndicator];
	}];
}

-(void)checkWebConnectivity{
		// hit firebase to check wheather user is online or not
	[[UsersStore shared] getWebStatusForUserWithCompletion:^(BOOL isOnline) {
		isWebActive = isOnline;
		[self setStatusIndicator];
	}];
}

-(void)setStatusIndicator{
	if (isUserOnline && isConnected && isWebActive) {
		_statusButton.backgroundColor = [UIColor colorFromHexRGB:0x00FF00];
	}
	else{
		_statusButton.backgroundColor = [UIColor colorFromHexRGB:0xFF0000];
	}
}

-(void)customiseStatusIndicator{
	_statusButton.layer.cornerRadius = 7;
	_statusButton.layer.borderColor = [UIColor whiteColor].CGColor;
	_statusButton.layer.borderWidth = 1;
}

-(void)setGreetingText{
		// Get greeting text
	NSString *greetingString = @"";
	
		// Get time from current date
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
	NSDateComponents *dateComponents = [gregorian components:NSCalendarUnitHour fromDate:[NSDate date]];
	
	NSInteger hour = [dateComponents hour];
	if (hour < 12){
			// Morning
		greetingString = @"Good Morning";
	}
	else if (hour > 12 && hour <= 16){
			// Afternoon
		greetingString = @"Good Afternoon";
	}
	else{
			// Evening
		greetingString = @"Good Evening";
	}
	
	_greetingLabel.text = [NSString stringWithFormat:@"%@, %@",greetingString,[[UsersStore shared].user.name componentsSeparatedByString:@" "][0]];
}

-(void)setListTableDelegate{
		// Set Delegate for getting cell Selection Action from Custom View
	_tripsTableView.viewDelegate = self;
	[_tripsTableView initializeView];
}

-(void)customiseNavigationBar{
		// Hide Back Button
	self.navigationController.navigationItem.hidesBackButton = true;
	
		// Remove Back Button Text for Next View
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
	
		// Create Owl Air Label
	UILabel *navigationTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 30)];
	navigationTitleLabel.text = @"Owl Air";
	navigationTitleLabel.textColor = [UIColor whiteColor];
	navigationTitleLabel.textAlignment = NSTextAlignmentCenter;
	navigationTitleLabel.font = [UIFont fontWithName:@"Whitney-Semibold" size:35];
		// Set Logo as Navigation titleView
	
	self.navigationItem.titleView = navigationTitleLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - TripTableView Delegate

-(void)selectedRow:(NSInteger)row tripObj:(Trip *)tripObj
{
		// get trip object
	_selectedTripObj = tripObj;
	
	if (isConnected && isUserOnline) {
			// perform segue to push to trip details view
		[self performSegueWithIdentifier:@"travelDetails" sender:self];
	}
	else if(!isUserOnline){
		[UIAlertView showWithTitle:@"Alert" message:@"Unable to communicate with OwlAir Services, Please check your connection and try again soon" buttons:@[@"OK"] completion:^(NSUInteger btn) {
				// No handler
		}];
	}
	else{
		[UIAlertView showWithTitle:@"Alert" message:@"Please check your connection and try again soon" buttons:@[@"OK"] completion:^(NSUInteger btn) {
				// No handler
		}];
	}
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"travelDetails"]) {
			// Set Trip object for Detail Page Control
		TravelDetailControl *detailsControl = [segue destinationViewController];
		detailsControl.tripObj = _selectedTripObj;
		detailsControl.delegate = self;
	}
}

#pragma mark - Updated Trip Details delegate
-(void)updateDetailsForTrip:(Trip *)tripObj withUpdatedTrip:(Trip *)updatedTrip{
		// replace current object with the updated object
	[_tripsTableView.tableContentArray replaceObjectAtIndex:[_tripsTableView.tableContentArray indexOfObject:tripObj] withObject:updatedTrip];
	[_tripsTableView reloadData];
}
@end
