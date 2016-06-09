//
//  CommandUser.h
//  Twilio
//
//  Created by Pankaj on 21/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

@import Foundation;
@class User;
/**
 Abstract action (follows 'command' design pattern)
 */

@interface Command : NSObject
//! Saved User
@property (strong, nonatomic) User *user;
//! Executes action
+ (void)execute;
//! Executes action
- (void)execute NS_REQUIRES_SUPER;
@end

////////////////////////////////////////////////////////////////////////////////

/**
 Logs in user with Facebook account
 */

@interface CommandLoginUserWithFacebook : Command
@end

////////////////////////////////////////////////////////////////////////////////

/**
 Logs in user with Facebook account
 */

@interface CommandLoginUserWithTwitter : Command
@end

////////////////////////////////////////////////////////////////////////////////

/**
 Logs in user with username or account number
 */

@interface CommandLoginUser : Command
//! Executes action with user
+ (Command *)commandWithUser:(User *)user;
@end

////////////////////////////////////////////////////////////////////////////////

/**
 Logs out user
 */

@interface CommandLogoutUser : Command
@end


