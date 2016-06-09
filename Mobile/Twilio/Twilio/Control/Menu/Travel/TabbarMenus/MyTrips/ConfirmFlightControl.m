//
//  ConfirmFlightControl.m
//  Twilio
//
//  Created by Shafi on 13/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "ConfirmFlightControl.h"
#import "TwilioHeader.h"

@interface ConfirmFlightControl ()<ReviewConfirmDelegate,UIAlertViewDelegate,ConfirmBirthdayDelegate,RTCDelegate,ConnectAgentDelegate>
{
	IBOutlet UIButton * _muteButton,*_headSetButton,*_speakerButton;
	
		// Call header
	CallNotificationView *_headerView;
	
		// Background scrollview
	UIScrollView *_backgroundScrollView;
	
		// ConfirmView
	ReviewConfirmView *_reviewConfirmView;
	
		// Bottom Section
	IBOutlet UIView *_buttonsView,*_poweredByBackgroundView;
	
	NSTimer * _timer;
	int _secondsLeft;
	
	UIBarButtonItem *_backButton;
	
		// Store Class Reference
	ConnectAgentStore *_connectAgentStoreRef;
	
		// RTC Reference
	ConnectAgentRTC *_connectAgentRTCRef;
}

@end

@implementation ConfirmFlightControl

- (void)viewDidLoad {
    [super viewDidLoad];
	
		// Customise Navigation bar
	[self customiseNavigationBar];
	
		// Initialize view/ customise View
	[self setUpView];
	
		// Setup Connect To Agent Store Class reference
	[self setUpConnectAgentStoreReference];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	self.tabBarController.tabBar.hidden = YES;
}

-(void) viewWillDisappear:(BOOL)animated {
	if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
			// Navigation button was pressed.
			// if Hangup popviewcontroller
//		[self cancelAction];
		if (_connectAgentRTCRef.endpoint.listening) {
			[_connectAgentRTCRef.endpoint unlisten];
		}
	}
	[super viewWillDisappear:animated];
	self.tabBarController.tabBar.hidden = NO;
}

-(void) viewDidDisappear:(BOOL)animated{
	[super viewDidDisappear:animated];
	
		// Unregister the TSEndpoint unlisten
	dispatch_async(dispatch_get_main_queue(), ^{
		[_connectAgentRTCRef.endpoint unlisten];
	});
}

-(void)setUpView{
		// Round Rect the buttons
	[self setButtonRoundedRect];

		// Create a background ScrollView which can be scrollable in case of smaller screen device(like iPhone 4s)
	_backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-120)];
	_backgroundScrollView.backgroundColor = [UIColor clearColor];
	
	
	if (_backgroundScrollView.frame.size.height <= 450) {
			// content size is larger than frame height enable scrolling
		_backgroundScrollView.scrollEnabled = true;
		_backgroundScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 340);
	}
	else{
			// if Content size if smaller than the height disable scrolling
		_backgroundScrollView.scrollEnabled = false;
	}
	[self.view addSubview:_backgroundScrollView];
	[self.view sendSubviewToBack:_backgroundScrollView];

		// Create Review Confirm view
	_reviewConfirmView = [[ReviewConfirmView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 425)];
	_reviewConfirmView.delegate = self;
	_reviewConfirmView.statusLabel.text = kFlightInfoText;
	[_reviewConfirmView setupViewWithTripDetails:self.tripObj];
	[_backgroundScrollView addSubview:_reviewConfirmView];
}

#pragma mark - UI Update for State Change

#pragma mark (connecting to agent) 1
-(void)customiseNavigationBar{
		// Customise navigation title View
	self.title = kConnectingToAgentText;
	[self updateConnectingAgentFont];
	
		// hide navigation backbutton
	self.navigationItem.hidesBackButton = YES;
	
	_backButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"BackButton"] style:UIBarButtonItemStyleDone target:self action:@selector(backButtonAction)];
}

#pragma mark (agent connected) 2
-(void)getConnectedToAgent{
		// Connect to agent view with negative ymargin to slide down
	CGRect headerFrame = CGRectMake(0, -100, [UIScreen mainScreen].bounds.size.width, 100);
	_headerView = [[CallNotificationView alloc] initWithFrame:headerFrame];
	_headerView.tag = 99;
	[self.view.window addSubview:_headerView];
	
		// Talking With : Customer Care Executive / Support person with whom call is connected
	/* Person Name comes here*/
	_headerView.agentNameLabel.text = @"Karen Fitzgerald";

		// animate with for slide down the connect to agent header view
	[UIView animateWithDuration:0.6
					 animations:^{
							 // set y Margin to zero
						 CGRect tempFrame = headerFrame;
						 tempFrame.origin.y = 0;
						
							 // Set frame for connect to agent view
						 _headerView.frame = tempFrame;
						 
							 // set background scroll view frame
						 _backgroundScrollView.frame = CGRectMake(_backgroundScrollView.frame.origin.x, 37, _backgroundScrollView.frame.size.width, _backgroundScrollView.frame.size.height-37);
						 _backgroundScrollView.contentOffset = CGPointZero;
					 } completion:^(BOOL finished) {
							 // Duration : Duration for the call which is going on with customer support / executives.
						 /* Call Duration comes here*/
						 _timer = [NSTimer scheduledTimerWithTimeInterval: 1.0 target:self selector:@selector(updateCountdown) userInfo:nil repeats: YES];
						 
						 NSDictionary *callEvent = @{@"User":[UsersStore shared].user.loginName,
													 @"BoardingPass":[NSString stringWithFormat:@"%@ -> %@",self.tripObj.source,self.tripObj.destination]};
						 [Flurry logEvent:@"Call Logs" withParameters:callEvent timed:YES];
					 }];
}

#pragma mark 3: agent searching for flights
-(void)searchingForFlightUpdate{
	_reviewConfirmView.statusLabel.text = kSearchingFlightText;
}

#pragma mark 4: agent presents new flight option
-(void)reviewAndConfirmFlight{
	_reviewConfirmView.statusLabel.text = kReviewAndConfirmText;
	
		// Update the date to plus two days
	NSDate *tripDate = [NSDate dateFromString:self.tripObj.arrivalDate withFormat:@"MM-dd-yyyy"];
	NSString *plusTwoDaysStr = [[NSDate plusTwoDays:tripDate] stringWithFormat:@"MM-dd-yyyy"];
	
		// get updated trip details
	Trip *updatedTripObj = [self.tripObj copy];
	updatedTripObj.arrivalDate = plusTwoDaysStr;
    updatedTripObj.departureDate = plusTwoDaysStr;
	
    // Update Status of the flight
	_backgroundScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 440);
	[_backgroundScrollView scrollRectToVisible:CGRectMake(_backgroundScrollView.contentSize.width - 1,_backgroundScrollView.contentSize.height - 1, 1, 1) animated:YES];
	
		// create update trip details
	[_reviewConfirmView updateTripDetails:updatedTripObj];
}

-(void) updateCountdown {
	int minutes, seconds;
	
	_secondsLeft++;
	minutes = (_secondsLeft % 3600) / 60;
	seconds = (_secondsLeft %3600) % 60;
	_headerView.durationLabel.text = [NSString stringWithFormat:@"%02d:%02d", minutes, seconds];
}

#pragma mark - ReviewConfirm Delegate Action
#pragma mark 7: rejected
-(void)rejectReviewAction{
		// Hide Confirm & Reject Button from the View
	[_reviewConfirmView updateButtonVisiblity:true];
	
		// Update Status
	_reviewConfirmView.statusLabel.text = kStatusCancelText;

		// Update View Appearance
	[self updateFligthDetails:nil];
	
		// Remove Updated Card View
	[_reviewConfirmView popOutUpdateTripDetails];
	
		// Change state to 7 (user rejected)
	[_connectAgentStoreRef setStateWithValue:@(UserRejected)];
	
		// Refresh token enable to handle re-search again
	_connectAgentStoreRef.isEnabledSearchingFlight = false;
	_connectAgentStoreRef.isUpdatedWithNewFlightOption = false;
}

-(void)reintialiseFlightSearch{
	_reviewConfirmView.statusLabel.text = kSearchingOtherFlightText;
//#warning Perform this action when agent is searching of flights
//	[self performSelector:@selector(reviewAndConfirmFlight) withObject:nil afterDelay:5];
}

-(void)confirmReviewAction{
		// Flurry event
	[Flurry logEvent:@"Confirm Flight Change"];

		// Authenticate with Touch ID
	[self authenticateWithTouchID];
}

-(void)authenticateWithTouchID{
	LAContext *context = [[LAContext alloc] init];
 
	NSError *error = nil;
	if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
		
		[context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
				localizedReason:@"Authenticate using your finger"
						  reply:^(BOOL success, NSError *error) {
							  if (success) {
									  // User authenticated successfully, take appropriate action
								  dispatch_async(dispatch_get_main_queue(), ^{
										  // Valid user and Authentication is success update Date with hardcoded value
									  [self confirmDate:@"08-29-2015" forView:nil];
								  });
							  } else {
									  // User did not authenticate successfully, look at error and take appropriate action
								  [self showAlertWithMessage:@"There was a problem verifying your identity."];
							  }
							  
						  }];
	} else {
			// Could not evaluate policy; look at authError and present an appropriate message to user
		[self showAlertWithMessage:@"Your device cannot authenticate using TouchID."];
	}
}


-(void)showAlertWithMessage:(NSString *)alertMessage{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
													message:alertMessage
												   delegate:self
										  cancelButtonTitle:@"Cancel"
										  otherButtonTitles:@"Confirm Birthday",nil];
	[alert show];
}

#pragma mark - Button Action

-(IBAction)speakerAction:(id)sender{
    [_connectAgentRTCRef setAudioOutput];
    // Set action to put the call on speaker mode
}

-(IBAction)hangoutAction:(id)sender{
    // Set action to allow call in hangout mode
    // Hangup and dismiss controller to previous controller

    // Slide Top / Bottom View
    // animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 
							 // Hide Buttons
						 [_reviewConfirmView updateButtonVisiblity:true];
						 
							 // Update Navigation View
						 [self updateDefaultNavigationFont];
						 self.title = @"Upcoming Trip";
						 
							 // show navigation backbutton
						 self.navigationItem.leftBarButtonItem = _backButton;
						 
							 // Slide Views
							 // Header View (Talking to Agent Section)
						 _headerView.frame = CGRectMake(_headerView.frame.origin.x, _headerView.frame.origin.y-_headerView.frame.size.height, _headerView.frame.size.width, _headerView.frame.size.height);
						 [_headerView removeFromSuperview];
						 
						 _backgroundScrollView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
						 _reviewConfirmView.frame = CGRectMake(0, 0, _reviewConfirmView.frame.size.width, _reviewConfirmView.frame.size.height);
							 // Bottom Section
						 _poweredByBackgroundView.frame = CGRectMake(_poweredByBackgroundView.frame.origin.x,
																	 [UIScreen mainScreen].bounds.size.height,
																	 _poweredByBackgroundView.frame.size.width,
																	 _poweredByBackgroundView.frame.size.height);
						 
						 _buttonsView.frame = CGRectMake(_buttonsView.frame.origin.x, [UIScreen mainScreen].bounds.size.height, _buttonsView.frame.size.width, _buttonsView.frame.size.height);
					 }
					 completion:^(BOOL finished) {
						 [self cancelAction];

							 // Hide Updated Status & Updated View
						 if (_reviewConfirmView.isUpdatedDetails) {
							 _reviewConfirmView.statusLabel.text = kStatusUpdatedText;
							 _reviewConfirmView.existingDetailCardView.hidden = YES;
						 }
						 else{
							 _reviewConfirmView.statusLabel.text = kFlightInfoText;
							 [_reviewConfirmView popOutUpdateTripDetails];
						 }
						 
						 _buttonsView.hidden = YES;
						 _poweredByBackgroundView.hidden = YES;
						 
							 // Set call state for complete (8)
						 [_connectAgentStoreRef setStateWithValue:@(CallCompleted)];
						 
							 // Disconnect the call
						 [_connectAgentRTCRef.conversation disconnect];
						 
							 // Flurry Action
						 [Flurry logEvent:@"Hangout"];
						 if (_timer.isValid) {
							 [Flurry endTimedEvent:@"Call Logs" withParameters:nil];
						 }
					 }];
}

-(IBAction)muteAction:(id)sender{
		// Set action to mute the call
		// If its muted already, unmute
	if (_connectAgentRTCRef.conversation.localMedia.microphoneMuted) {
		[_connectAgentRTCRef.conversation.localMedia setMicrophoneMuted:false];
	}
	else{
			// if not muted, mute the call
		[_connectAgentRTCRef.conversation.localMedia setMicrophoneMuted:true];
	}
}

-(void)backButtonAction{
	
		// Unregister the TSEndpoint unlisten
	dispatch_async(dispatch_get_main_queue(), ^{
		if (_connectAgentRTCRef.endpoint.listening) {
			[_connectAgentRTCRef.endpoint unlisten];
		}
	});
	
    // UnHide Tabbar
    self.tabBarController.tabBar.hidden = NO;
    
		// Current Screen minus 2 (viewControllers.count-3)
	id listControl = [self.navigationController.viewControllers objectAtIndex:self.navigationController.viewControllers.count-3];
	[self.navigationController popToViewController:listControl animated:YES];
}

#pragma mark - UIAlertView Delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	if (buttonIndex ==1){
			// Show Birth Verification
			// Authenticate with Birthday
		[self authenticateWithBirthDay];
	}
}

-(void)authenticateWithBirthDay{
	
		// Hide Buttons
	[_reviewConfirmView updateButtonVisiblity:true];
	
		// On confirm ask for Birthday
	CGFloat screenHeight	= [UIScreen mainScreen].bounds.size.height,
	screenWidth		= [UIScreen mainScreen].bounds.size.width;
	
		// add Confirm birthday view
	ConfirmBirthdayView *confirmBirthdayView = [[ConfirmBirthdayView alloc] initWithFrame:CGRectMake(0, screenHeight, screenWidth, 320)];
	confirmBirthdayView.delegate = self;
	[confirmBirthdayView setupView];
	[self.view addSubview:confirmBirthdayView];
	
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 [_reviewConfirmView updateButtonVisiblity:true];
						 
						 _backgroundScrollView.contentSize = CGSizeMake(_backgroundScrollView.frame.size.width, 440);
							 // resize view
						 CGFloat minusYMargin = 0; // Scroll behind the Header Call Notification View for smaller screen
						 if ([UIScreen mainScreen].bounds.size.height == 667) {
								 // iPhone 6
							 minusYMargin = -70;
						 }
						 else if ([UIScreen mainScreen].bounds.size.height == 568) {
								 // for screen bigger than iPhone 5
							 minusYMargin = -100;
						 }
						 else if ([UIScreen mainScreen].bounds.size.height == 480){
								 // iPhone 4
							 minusYMargin = -180;
						 }
						 
						 confirmBirthdayView.frame = CGRectMake(0, screenHeight-350, screenWidth, 320);
						 _backgroundScrollView.frame = CGRectMake(0, minusYMargin, screenWidth, 425);
						 _backgroundScrollView.scrollEnabled = false;
						 
						 _reviewConfirmView.isUpdatedDetails = true;
						 
					 }
					 completion:nil];
}

#pragma mark - ConfirmBirth Delegate
-(void)confirmDate:(NSString *)dateStr forView:(ConfirmBirthdayView *)view{
	if (view) {
			// confirm from birthday view
			// Change state to 6 (confirmed birthday)
		[_connectAgentStoreRef setStateWithValue:@(BirthDayConfirmation)];
	}
	else{
			// confirm from touch id
			// Change state to 5 (confirmed touch id)
		[_connectAgentStoreRef setStateWithValue:@(TouchIDConfirmation)];
	}
	
	[_reviewConfirmView updateButtonVisiblity:true];

		// Update view appearance
	[self updateFligthDetails:view];
	
		// Update Status
	_reviewConfirmView.statusLabel.text = kStatusUpdatedText;
	_reviewConfirmView.isUpdatedDetails = true;
	
	[_reviewConfirmView performSelector:@selector(popOutExistingTripDetails) withObject:nil afterDelay:2];
		// Update details
	if ([self.delegate respondsToSelector:@selector(updateFlightChanges:)]) {
		[self.delegate updateFlightChanges:self.tripObj];
	}
}

-(void)updateFligthDetails:(ConfirmBirthdayView *)view{
	
	CGFloat screenHeight	= [UIScreen mainScreen].bounds.size.height,
	screenWidth		= [UIScreen mainScreen].bounds.size.width;
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
							 // resize view
						 view.frame = CGRectMake(0, screenHeight, screenWidth, 320);
						 _backgroundScrollView.frame = CGRectMake(0, 37, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-160);
						 if (_backgroundScrollView.frame.size.height <= 450) { // content size is smaller than frame height enable scrolling
							 _backgroundScrollView.scrollEnabled = true;
							 _backgroundScrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, 420);
							 _backgroundScrollView.contentOffset = CGPointZero;
						 }
						 else{
								 // if Content size if smaller than the height diable scrolling
							 _backgroundScrollView.scrollEnabled = false;
						 }
						 
							 // remove birthday view from main view
						 [view removeFromSuperview];
						 
							 // Update Navigation View
						 self.navigationItem.titleView = nil;
						 self.title = @"Owl Air";
							 // hide navigation backbutton
						 self.navigationItem.leftBarButtonItem = _backButton;
						 
						 if ([UIScreen mainScreen].bounds.size.height > 568) {
								 // for screen bigger than iPhone 5
							 _backgroundScrollView.scrollEnabled = false;
						 }
						 else{
							 _backgroundScrollView.scrollEnabled = true;
						 }
					 }
					 completion:^(BOOL finished) {
					 }];
}


#pragma mark - Cancel Perform Selector
-(void)cancelAction
{
		// Cancel Triggered Action
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(getConnectedToAgent) object:nil];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(searchingForFlightUpdate) object:nil];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reviewAndConfirmFlight) object:nil];
	
	[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reintialiseFlightSearch) object:nil];
	self.navigationController.delegate = nil;
	
	[NSObject cancelPreviousPerformRequestsWithTarget:_connectAgentRTCRef];
	_connectAgentRTCRef.delegate = nil;
	
	[NSObject cancelPreviousPerformRequestsWithTarget:_connectAgentStoreRef];
	_connectAgentStoreRef.delegate = nil;
}

#pragma mark - Firebase

-(void)setUpConnectAgentStoreReference{
		// generate a reference for connect to agent class
	_connectAgentStoreRef = [ConnectAgentStore new];
	_connectAgentStoreRef.delegate = self;
	[_connectAgentStoreRef setUpStore];
		
		// Register user for Pending queue
	[_connectAgentStoreRef registerEndpointToPendingQueue];
	
		// Check for tokens
	[_connectAgentStoreRef checkForToken];
}

#pragma mark - TwilioRTC

-(void)setUpConnectAgentRTCWithToken:(NSString *)tokenStr{
		// Create a reference for RTC Class
	_connectAgentRTCRef = [ConnectAgentRTC new];
	_connectAgentRTCRef.delegate = self;
		// Setup RTC
	[_connectAgentRTCRef setUpTwilioRTCWithToken:tokenStr];
}

#pragma mark - ConnectAgentRtc Delegate
/*
 Begin Call/Collaboration with agent
 */
-(void)didStartedCollaboration{
	
		// Set status to connected to agent
	[self getConnectedToAgent];
	
		// Change state to 2 (connected with agent)
	[_connectAgentStoreRef setStateWithValue:@(AgentConnected)];

		// Check for session state
	[_connectAgentStoreRef checkForSessionState];
}

/*
 End Call with Agent
	*/
-(void)didEndedCollaboration{
		// Disconnect
	[_connectAgentRTCRef.conversation disconnect];
	
	[self hangoutAction:_headSetButton];
}

-(void)updateToken:(NSString *)tokenString{
	[_connectAgentStoreRef setTokenWithValue:tokenString];
	
	
		//Push endpoint name to /queue
	[_connectAgentStoreRef registerUserEndpointToQueue];
	
		// Change state to 1
	[_connectAgentStoreRef setStateWithValue:@(AgentConnecting)];
	[_connectAgentStoreRef setUserNameForEndpoint];
}
#pragma mark - Connect Agent Delegate
-(void)enableCallWithToken:(NSString *)tokenStr{
	NSLog(@"Token -- %@",tokenStr);
	
		//Start call with new access token and endpoint
	[self setUpConnectAgentRTCWithToken:tokenStr];
}


-(void)updateUIWithState:(NSInteger)state{
	NSLog(@"state to Update UI -- %@",@(state));

	if (state == SearchingFlight) {
			// UI Searching Flight UI
		[self searchingForFlightUpdate];
	}
	else if (state == NewFightOption){
			// Update UI with new flight option
		[self reviewAndConfirmFlight];
	}
}

#pragma mark - Helper Method

-(void)updateConnectingAgentFont{
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
		NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
												   [UIColor whiteColor],NSForegroundColorAttributeName,
												   [UIFont systemFontOfSize:14],NSFontAttributeName,
												   nil];
		[self.navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
	}
}

-(void)updateDefaultNavigationFont{
	if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0){
		NSDictionary *navbarTitleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
												   [UIColor whiteColor],NSForegroundColorAttributeName,
												   [UIFont systemFontOfSize:20],NSFontAttributeName,
												   nil];
		[self.navigationController.navigationBar setTitleTextAttributes:navbarTitleTextAttributes];
	}
}

-(void)setButtonRoundedRect{
		// Round Rect below Card View
	_muteButton.layer.cornerRadius = _muteButton.frame.size.width/2;
	_headSetButton.layer.cornerRadius = _headSetButton.frame.size.width/2;
	_speakerButton.layer.cornerRadius = _speakerButton.frame.size.width/2;
}
//#pragma mark - Dealloc
//
//-(void)dealloc{
//		//	 Remove reference from view and make it nil
//	[_muteButton removeFromSuperview];
//	_muteButton = nil;
//	
//	[_headSetButton removeFromSuperview];
//	_headSetButton = nil;
//	
//	[_speakerButton removeFromSuperview];
//	_speakerButton = nil;
//
//	
//	[_headerView removeFromSuperview];
//	_headerView = nil;
//	
//	[_backgroundScrollView removeFromSuperview];
//	_backgroundScrollView = nil;
//
//	
//	[_reviewConfirmView removeFromSuperview];
//	_reviewConfirmView = nil;
//
//	
//	[_buttonsView removeFromSuperview];
//	_buttonsView = nil;
//
//	
//	[_poweredByBackgroundView removeFromSuperview];
//	_poweredByBackgroundView = nil;
//
//	
//	_backButton = nil;
//	
//		// Invalidate timer and make it reference nil
//	[_timer invalidate];
//	_timer = nil;
//	
//	_connectAgentStoreRef = nil;
//		// Unregister the TSEndpoint unlisten
//	
//	dispatch_async(dispatch_get_main_queue(), ^{
//		if (_connectAgentRTCRef.endpoint.listening) {
//			[_connectAgentRTCRef.endpoint unlisten];
//		}
//		
//			//	 de-refer delegate
//		_connectAgentRTCRef.delegate = nil;
//		_connectAgentRTCRef = nil;
//	});
//}
@end
