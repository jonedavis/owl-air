//
//  Constant.h
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

typedef enum : NSUInteger {
	AgentConnecting = 1,
	AgentConnected,
	SearchingFlight,
	NewFightOption,
	TouchIDConfirmation,
	BirthDayConfirmation,
	UserRejected,
	CallCompleted
} CallState;

#define kAUTOLOGGEDIN				@"IsAutoLoggedIn"

	// Controller Id/Name

#define kSliderControl				@"SliderControl"
#define kTabBarControl				@"TravelTabBar" 
#define kLoginControl				@"LoginControl"

	// Image Name
#define kUberLogoWhite				@"UberAirLogoWhite"

	// Twilio Keys
#define kTwilioSID					@"ENTER_SID_HERE"

#define kAppRedColor				@"E22026"
#define kNavigationColor			@"E22026"
#define kAppGrayColor				@"B1AC9F"

#define kConnectingToAgentText		@"Connecting to an agent..."
#define kReviewAndConfirmText		@"Review and Confirm Your Flight"
#define kStatusUpdatedText			@"Your Flight Has Been Updated"
#define kStatusCancelText			@"Your Flight Confirmation has been cancelled"
#define kFlightInfoText				@"Your flight information"
#define kFlightUpdatedInfoText		@"Your Updated flight information"
#define kSearchingFlightText		@"Karen is searching for flights"
#define kSearchingOtherFlightText	@"Karen is searching for other flights"

// Firebase
#define kFireBaseEndPoint       [[NSUserDefaults standardUserDefaults] objectForKey:kFirebaseKey]
#define kFirebaseKey            @"firebaseURL"
#define kFireBaseDev			@"FIRE_BASE_URL"
#define kFireBaseSandbox        @"FIRE_BASE_URL"


	// TwilioRTC 
#define kTwilioAccountSID			@"Twilio_AccountSID_HERE"
#define kTwilioAuthToken			@"7bd451b90cf7fb79a5c56309a51f75fd"

	/*! @brief Flurry id from Jon */
#define kFlurryKey					@"FLURRY_KEY_HERE" 
#define kHockeyAppID				@"HOCKEY_APP_ID_HERE"
 // Token Generation
#define kTokenGenerateURL			@"URL_HERE/owlair13-dev/generatenew.php?UID={user-id}"
#define kTokenUserId				@"{user-id}"
