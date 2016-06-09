//
//  ConnectAgentRTC.m
//  Twilio
//
//  Created by Shafi on 05/07/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "ConnectAgentRTC.h"
#import "TwilioHeader.h"

@interface ConnectAgentRTC ()<TwilioConversationsClientDelegate, TWCConversationDelegate,TwilioAccessManagerDelegate>

@property (nonatomic, assign) BOOL isSpeakerOn;

@property (nonatomic, strong) TWCIncomingInvite* incomingInvite;
@property (nonatomic, strong) TwilioAccessManager *accessManager;
@end

@implementation ConnectAgentRTC

- (void)setUpTwilioRTCWithToken:(NSString *)token {
	/* Different logging levels can be found in TwilioRTC.h */
	[TwilioConversationsClient setLogLevel:TWCLogLevelDebug];
	[TwilioConversationsClient setAudioOutput:TWCAudioOutputReceiver];
    self.isSpeakerOn = NO;
    if (!self.endpoint) {
		self.accessManager = [TwilioAccessManager accessManagerWithToken:token delegate:self];
		self.endpoint = [TwilioConversationsClient conversationsClientWithToken:token delegate:self];
        [self.endpoint listen];
    }
}

- (void)setAudioOutput {
    if (self.isSpeakerOn) {
        self.isSpeakerOn = NO;
        [TwilioConversationsClient setAudioOutput:TWCAudioOutputReceiver];
    }
    else {
        self.isSpeakerOn = YES;
        [TwilioConversationsClient setAudioOutput:TWCAudioOutputSpeaker];
    }
}

#pragma mark - TwilioConversationsClientDelegate
/** This method is invoked on successful completion of registration.  */

- (void)conversationsClientDidStartListeningForInvites:(TwilioConversationsClient *)conversationsClient {
	NSLog(@"Now listening for Conversation invites...");
	if ([self.delegate respondsToSelector:@selector(updateToken:)]) {
		[self.delegate updateToken:self.accessManager.token];
	}
}

/** This method is invoked on failure to complete registration.  */
- (void)conversationsClient:(TwilioConversationsClient *)conversationsClient didFailToStartListeningWithError:(NSError *)error {
	NSLog(@"Failed to listen for Conversation invites: %@", error);
    // show error message
}

/* This method is invoked when the SDK stops listening for Conversations invites */
- (void)conversationsClientDidStopListeningForInvites:(TwilioConversationsClient *)conversationsClient error:(NSError *)error {
	if (!error) {
		NSLog(@"Successfully stopped listening for Conversation invites");
	} else {
		NSLog(@"Stopped listening for Conversation invites (error): %ld", (long)error.code);
	}
}

/** This method is invoked when incoming call is received.  */
- (void)conversationsClient:(TwilioConversationsClient *)conversationsClient didReceiveInvite:(TWCIncomingInvite *)invite {
	NSLog(@"Conversations invite received: %@", invite);

	self.incomingInvite = invite;

	if (self.delegate != nil) {
		dispatch_async(dispatch_get_main_queue(), ^{
			TWCLocalMedia *localMedia = [[TWCLocalMedia alloc] init];
//			localMedia.cameraPaused = false;
//			[self.incomingInvite acceptWithLocalMedia:localMedia conversationDelegate:self];
			[self.incomingInvite acceptWithLocalMedia:localMedia
										   completion:[self acceptHandler]];
		});
	}
}

- (void)conversationsClient:(TwilioConversationsClient *)conversationsClient inviteDidCancel:(TWCIncomingInvite *)invite
{
}

#pragma mark -  TwilioAccessManagerDelegate

- (void)accessManagerTokenExpired:(TwilioAccessManager *)accessManager {
	NSLog(@"Token expired. Please update access manager with new token.");
}

- (void)accessManager:(TwilioAccessManager *)accessManager error:(NSError *)error {
	NSLog(@"AccessManager encountered an error : %ld", (long)error.code);
}

#pragma mark - Helper

- (TWCInviteAcceptanceBlock)acceptHandler
{
	return ^(TWCConversation * _Nullable conversation, NSError * _Nullable error) {
		if (conversation) {
			conversation.delegate = self;
			_conversation = conversation;
			[[UIApplication sharedApplication] setIdleTimerDisabled:true];
			if ([self.delegate respondsToSelector:@selector(didStartedCollaboration)]) {
				[self.delegate didStartedCollaboration];
			}
		}
		else {
			NSLog(@"Invite failed with error: %@", error);
			[_conversation disconnect];
		}
	};
}

#pragma mark - TWCConversationDelegate

- (void)conversation:(TWCConversation *)conversation didConnectParticipant:(TWCParticipant *)participant
{
//	NSLog(@"Participant connected: %@", [participant identity]);
}

- (void)conversation:(TWCConversation *)conversation didFailToConnectParticipant:(TWCParticipant *)participant error:(NSError *)error
{
//	NSLog(@"Participant failed to connect: %@ with error: %@", [participant identity], error);
	[_conversation disconnect];
}

- (void)conversation:(TWCConversation *)conversation didDisconnectParticipant:(TWCParticipant*)participant
{
//	NSLog(@"Participant disconnected: %@", [participant identity]);
	if ([_conversation.participants count] <= 1) {
		[_conversation disconnect];
	}
}


- (void)conversationEnded:(TWCConversation *)conversation
{
	_conversation = nil;
	
	[[UIApplication sharedApplication] setIdleTimerDisabled:false];
	if ([self.delegate respondsToSelector:@selector(didEndedCollaboration)]) {
		[self.delegate didEndedCollaboration];
	}
}

- (void)conversationEnded:(TWCConversation *)conversation error:(NSError *)error
{
	_conversation = nil;
	
	[[UIApplication sharedApplication] setIdleTimerDisabled:false];
	if ([self.delegate respondsToSelector:@selector(didEndedCollaboration)]) {
		[self.delegate didEndedCollaboration];
	}
}

#pragma mark - Dealloc

-(void)dealloc{
		// Remove reference from view and make it nil
	_delegate = nil;
	
	[_conversation disconnect];
	_conversation.delegate = nil;
	_conversation = nil;
	_accessManager = nil;
}
@end
