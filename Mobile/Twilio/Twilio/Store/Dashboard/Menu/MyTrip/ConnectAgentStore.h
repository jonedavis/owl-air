//
//  ConnectAgentStore.h
//  Twilio
//
//  Created by Shafi on 05/07/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Firebase;

@protocol ConnectAgentDelegate <NSObject>

	/*  
		Protocol to get called whenever getting a valid token for the user endpoint
	 */
-(void)enableCallWithToken:(NSString *)tokenStr;

	/*
		Update the UI Based on the state getting from FireBase database.
	 */

-(void)updateUIWithState:(NSInteger)state;

@end

@interface ConnectAgentStore : NSObject

#pragma mark - Variables
	/*
		Delegate Referecene for passing the control to initiate the call
	 */
@property (nonatomic, assign) id <ConnectAgentDelegate> delegate;

	/*
		user endpoint unique id generate from timestamp
	 */
@property (nonatomic, strong) NSString *userEndpointRef;


	/* 
		boolean to check wheather call token is register to for TwilioRTC
	 */
@property (nonatomic, readwrite) BOOL isRequestedForCall;

/*
	boolean to check wheather State for agent searching for flights updated the UI
 */
@property (nonatomic, readwrite) BOOL isEnabledSearchingFlight;

/*
	boolean to check wheather State for agent presents new flight option updated the UI
 */
@property (nonatomic, readwrite) BOOL isUpdatedWithNewFlightOption;

#pragma mark - Methods
/*
 initialize default Values
 */

-(void)setUpStore;

	/*
	 Register the session state with value passed from the control, all possible states are 
	 
	 1: connecting to agent
	 2: agent connected
	 3: agent searching for flights
	 4: agent presents new flight option
	 - 5: confirmed touch id
	 - 6: confirmed birthday
	 - 7: rejected
	 
	 from 5 (confirmed touch id)
	 from 6 (confirmed birthday)
	 8: complete/disconnect
	 
	 from 7 (rejected)
	 (return to 3)
	 */
-(void)setStateWithValue:(NSNumber *)state;
-(void)setTokenWithValue:(NSString *)token;
-(void)setUserNameForEndpoint;
/*
 Register the user for pending queue
 */
-(void)registerEndpointToPendingQueue;

/*
 Register the user endpoint for queue
 */
-(void)registerUserEndpointToQueue;

/*
 Check if token is avaliable for user endpoint
 */
-(void)checkForToken;

/*
 Check if State has been changes from web, based on the value update the UI as well
 */
-(void)checkForSessionState;
@end
