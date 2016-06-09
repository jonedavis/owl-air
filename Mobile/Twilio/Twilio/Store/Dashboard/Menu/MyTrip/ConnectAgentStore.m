	//
	//  ConnectAgentStore.m
	//  Twilio
	//
	//  Created by Shafi on 05/07/15.
	//  Copyright (c) 2015 Impekable. All rights reserved.
	//

#import "ConnectAgentStore.h"
#import "TwilioHeader.h"

@implementation ConnectAgentStore


#pragma mark - Initiate Call

/*
 Getter/Setter for Endpoint reference
 */

-(NSString *)userEndpointRef{
	if (!_userEndpointRef) {
		_userEndpointRef = [Utility generateSessionIdentifier];
	}
	
	return _userEndpointRef;
}

/*
 initialize default Values
 */

-(void)setUpStore{
	_isEnabledSearchingFlight = false;
	_isRequestedForCall = false;
	_isUpdatedWithNewFlightOption = false;
}


-(void)setUserNameForEndpoint{
		// This will register the session into firebase server as state 1
	Firebase *userSessionFBRef = [[[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kFireBaseEndPoint,_userEndpointRef]] childByAppendingPath:@"name"];
	[userSessionFBRef setValue:[UsersStore shared].user.loginName];
}
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
-(void)setStateWithValue:(NSNumber *)state{
		// This will register the session into firebase server as state 1
	Firebase *userSessionFBRef = [[[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kFireBaseEndPoint,_userEndpointRef]] childByAppendingPath:@"state"];
	[userSessionFBRef setValue:state];
}


-(void)setTokenWithValue:(NSString *)token{
		// This will register the session into firebase server as token
	Firebase *userSessionFBRef = [[[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kFireBaseEndPoint,_userEndpointRef]] childByAppendingPath:@"token"];
	[userSessionFBRef setValue:token];
}
#pragma mark - Register for Pending
/*
 Register the user for pending queue
 */
-(void)registerEndpointToPendingQueue{
    // Create a firebase reference
	Firebase *pendingQueueFB = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/pending",kFireBaseEndPoint]];
	
	NSLog(@"self.userEndpointRef - %@",self.userEndpointRef);
	
	[pendingQueueFB observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
		Firebase *pendingListRef ;
		if(snapshot.value == [NSNull null]) {
			NSLog(@"No pending");
			pendingListRef = [pendingQueueFB childByAppendingPath:@"0"];
			[pendingListRef setValue:self.userEndpointRef withCompletionBlock:nil];
		} else {
			NSArray *pendingArray = snapshot.value;
			NSLog(@"pendingArray: %@", pendingArray);
			
			pendingListRef = [pendingQueueFB childByAppendingPath:[NSString stringWithFormat:@"%@",@(pendingArray.count)]];
			[pendingListRef setValue:self.userEndpointRef withCompletionBlock:nil];
		}
	}];
		// Get content from endpoint which is avialble on firebase
}

#pragma mark - set Endpoint to queue
/*
 Register the user endpoint for queue
 */
-(void)registerUserEndpointToQueue{
    // Create a firebase reference
    Firebase *queueFBRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/names/%@/queue",kFireBaseEndPoint,[UsersStore shared].user.loginName]];
    
    [queueFBRef observeSingleEventOfType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        Firebase *queueListRef = queueFBRef;
        if(snapshot.value == [NSNull null]) {
            NSLog(@"Queue is empty");
            queueListRef = [queueListRef childByAppendingPath:@"0"];
            [queueListRef setValue:self.userEndpointRef withCompletionBlock:nil];
        } else {
            NSArray *queueList = snapshot.value;
            NSLog(@"queue array: %@", queueList);
            queueListRef = [queueListRef childByAppendingPath:[NSString stringWithFormat:@"%@",@(queueList.count)]];
            [queueListRef setValue:self.userEndpointRef withCompletionBlock:nil];
        }
    }];
//		// Get content from endpoint which is avialable on firebase
}

#pragma mark - Check for Token
/*
 Check if token is avaliable for user endpoint
 */

-(void)checkForToken{
//	Firebase *tokenRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kFireBaseEndPoint,self.userEndpointRef]];
//	
//	[tokenRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
//		
//		if (snapshot.value != [NSNull null]){
//			NSDictionary *sessionDetails = snapshot.value;
//			if (sessionDetails[@"token"] != [NSNull null]) {
//				if ([self.delegate respondsToSelector:@selector(enableCallWithToken:)] && !_isRequestedForCall) {
//					_isRequestedForCall = true;
//					[self.delegate enableCallWithToken:sessionDetails[@"token"]];
//				}
//				return ;
//			}
//		}
//	}];

	[[TokenStore shared] generateTokenForId:self.userEndpointRef withCompletion:^(NSString *token) {
			//
		[self.delegate enableCallWithToken:token];
	}];
}


#pragma mark - Check for Available State
/*
 Check if State has been changes from web, based on the value update the UI as well
 */

-(void)checkForSessionState{
	Firebase *tokenRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/%@",kFireBaseEndPoint,self.userEndpointRef]];
	
	[tokenRef observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
		
		if (snapshot.value != [NSNull null]){
			NSDictionary *sessionDetails = snapshot.value;
			if (sessionDetails[@"state"] != [NSNull null] && [self.delegate respondsToSelector:@selector(updateUIWithState:)]) {
				NSInteger sessionState = [sessionDetails[@"state"] integerValue];
				if (!_isEnabledSearchingFlight && (sessionState == SearchingFlight)) {
					_isEnabledSearchingFlight = true;
					[self.delegate updateUIWithState:sessionState];
				}
				if (!_isUpdatedWithNewFlightOption && (sessionState == NewFightOption)) {
					_isUpdatedWithNewFlightOption = true;
					[self.delegate updateUIWithState:sessionState];
				}
				return ;
			}
		}
	}];
}
#pragma mark - Dealloc

-(void)dealloc{
		// Remove reference from view and make it nil
	_delegate = nil;
	
	_userEndpointRef = nil;

}
@end
