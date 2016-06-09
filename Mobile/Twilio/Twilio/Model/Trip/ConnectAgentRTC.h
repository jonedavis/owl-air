//
//  ConnectAgentRTC.h
//  Twilio
//
//  Created by Shafi on 05/07/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TwilioConversationsClient/TwilioConversationsClient.h>


@protocol RTCDelegate <NSObject>

	/* 
	 Begin Call/Collaboration with agent
	 */
-(void)didStartedCollaboration;

	/*
	 End Call with Agent
	*/
-(void)didEndedCollaboration;


	/*
	 Update Token
	 */
-(void)updateToken:(NSString *)tokenString;
@end

	/*
	 ConnectAgentRTC : This class take care of  all the Call/Collaboration stuff dealing with RTC(TwilioRTC)
	 */
@interface ConnectAgentRTC : NSObject

	// For passing back the callback method to change the state on firebase server
@property (nonatomic, assign) id <RTCDelegate> delegate;


	// Local EndPoint
@property (nonatomic, strong) TwilioConversationsClient* endpoint;

	// Invitation to connect
@property (nonatomic, strong) TWCConversation* conversation;

- (void)setAudioOutput;
/*
 Set Up Twilio RTC with token from firebase
 */
- (void)setUpTwilioRTCWithToken:(NSString *)token;

@end
