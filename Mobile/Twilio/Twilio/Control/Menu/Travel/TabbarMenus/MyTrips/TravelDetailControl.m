//
//  TravelDetailControl.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "TravelDetailControl.h"
#import "TwilioHeader.h"

#define kWidth [UIScreen mainScreen].bounds.size.width-20
#define kButtonHeight 50
#define kXMargin	10
#define kViewHeight	270

@interface TravelDetailControl ()<CustomActionSheetDelegate,UIAlertViewDelegate,ConfirmFlightDelegate>
{	
		//for Auto Set yMargin
	UIScrollView *_backgroundScrollView;
	CGFloat _yMargin;
	
		// Buttons
	UIButton *checkinButton,*talkToAgentButton;
	IBOutlet UIButton *_statusButton;

		// Trip Details View
	TripView *tripView;
	BOOL isConnected,isUserOnline,isWebActive;
}
@end

@implementation TravelDetailControl

- (void)viewDidLoad {
    [super viewDidLoad];
		// Set Title for View
	self.title = @"Upcoming Trip";
	[self customiseBackButton];
	
		// customising status indicator
	[self customiseStatusIndicator];

		// Add Details View with values from Trip Object
	[self addScrollView];
	[self addTripDetailsView];
	[self addButtons];
	
	
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


-(void)addScrollView{
	_backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kWidth+20, [UIScreen mainScreen].bounds.size.height-64-44)];
	_backgroundScrollView.backgroundColor = [UIColor clearColor];
	[self.view addSubview:_backgroundScrollView];
	
		// Enable Scrolling for IPhone 4 Screen
	if ([UIScreen mainScreen].bounds.size.height == 480) {
		_backgroundScrollView.scrollEnabled = YES;
	}
	else{
		_backgroundScrollView.scrollEnabled = NO;
	}
}

-(void)customiseBackButton{
		// Hide Back Button
	self.navigationController.navigationItem.hidesBackButton = true;
	
		// Remove Back Button Text for Next View
	self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:self.navigationItem.backBarButtonItem.style target:nil action:nil];
}

-(void)addTripDetailsView{
	_yMargin = 15;
		// Create details View
	tripView = [[TripView alloc] initWithFrame:CGRectMake(kXMargin, _yMargin, kWidth , kViewHeight)];
	[tripView setupValuesFromTrip:self.tripObj];
	
	_yMargin += tripView.frame.size.height+10;
	
	[_backgroundScrollView addSubview:tripView];
}

-(void)addButtons{
		// Check In Button
	checkinButton = [Utility createButtonWithFrame:CGRectMake(kXMargin, _yMargin, kWidth, kButtonHeight)
													   title:@"CHECK IN" image:nil
											 backgroundColor:[Utility colorWithHexString:kAppRedColor]
													  target:self
													selector:@selector(checkInButtonAction:)];
	checkinButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
	[checkinButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_backgroundScrollView addSubview:checkinButton];
	
		// Include CheckIcon on Checkin Button
	UIImageView *checkImgVw = [[UIImageView alloc] initWithFrame:CGRectMake(checkinButton.center.x-65, 17, 16, 16)];
	checkImgVw.image = [UIImage imageNamed:@"CheckIcon"];
	[checkinButton addSubview:checkImgVw];
	
	_yMargin += kButtonHeight+10;
	
		// Talk to Agent Button
	talkToAgentButton = [Utility createButtonWithFrame:CGRectMake(kXMargin, _yMargin, kWidth, kButtonHeight)
													title:@"TALK TO AN AGENT" image:nil
										  backgroundColor:[Utility colorWithHexString:kAppGrayColor] target:self
												 selector:@selector(talkToAgentAction:)];
	talkToAgentButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
	[talkToAgentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[_backgroundScrollView addSubview:talkToAgentButton];
	
	_yMargin += kButtonHeight+10;

	[_backgroundScrollView setContentSize:CGSizeMake(_backgroundScrollView.frame.size.width, _yMargin-40) ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Action
-(IBAction)talkToAgentAction:(id)sender{
		// Flurry Event
	[Flurry logEvent:@"Talk to Agent"];

		// action to be perfrom on clicking Check in Button
	CustomActionSheet* actionSheet = [[CustomActionSheet alloc] initWithDelegate:self
																	buttonTitles:@[@"CHANGE FLIGHT",
																				   @"CANCEL FLIGHT",
																				   @"OTHER",
																				   @"CANCEL"]
																		   frame:CGRectMake(0,0 , [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
	
	
	[actionSheet setBackgroundColor:[UIColor clearColor]];
	[actionSheet showInView:self.view];
}

-(IBAction)checkInButtonAction:(id)sender{
		// Action to be perform on clicking More Button
}

-(void)requestForDeviceCall{
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:self.tripObj.agentNumber message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
	alertView.tag = 99;
	[alertView show];
}

-(void)customActionSheet:(CustomActionSheet *)customActionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
	switch (buttonIndex) {
		case 0:
				// CANCEL
			break;
		case 1:
				// Something else
			break;
		case 2:
				// Cancel Flight
			break;
		case 3:{
				// Change Flight
			if (isConnected && isUserOnline) {
					// perform segue to push to talkToAgent view
				[self performSegueWithIdentifier:@"talkToAgent" sender:self];
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
			break;
		}
		default:
			break;
	}
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex == 1) {
			// Make a call
		NSString *phoneNumber = [@"tel://" stringByAppendingString:self.tripObj.agentNumber];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:phoneNumber]];
	}
}

#pragma mark - Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	ConfirmFlightControl *confirmControl = [segue destinationViewController];
	confirmControl.tripObj = self.tripObj;
	confirmControl.delegate = self;
}


#pragma mark - ConfirmFlight Delegate
-(void)updateFlightChanges:(Trip *)tripDetails{
	
		// Update List from Main View
	if ([self.delegate respondsToSelector:@selector(updateDetailsForTrip:withUpdatedTrip:)]) {
		[self.delegate updateDetailsForTrip:self.tripObj withUpdatedTrip:tripDetails];
	}
		// Update Trip Details
	self.tripObj = tripDetails;
	[tripView setupValuesFromTrip:self.tripObj];
	
		// On Hang up disable Checkin and Talk to Agent Button
	checkinButton.hidden = true;
	talkToAgentButton.hidden = true;
	
		// Update Detials View Frame
	CGFloat navigationHeight = 44+64; // Navigation Bar + Tab Bar height
	tripView.frame = CGRectMake(tripView.frame.origin.x, ([UIScreen mainScreen].bounds.size.height-tripView.frame.size.height-navigationHeight)/2, tripView.frame.size.width, tripView.frame.size.height);
}
@end
