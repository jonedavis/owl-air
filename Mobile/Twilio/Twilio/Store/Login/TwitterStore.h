//
//  TwitterStore.h
//  Twilio
//
//  Created by Pankaj on 23/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

@import UIKit; // For presenting TWTRShareEmailViewController
@class User;
/**
 Store for all Twitter-related stuff
 @note: do not use this object directly - use UserStore instead
 */

@interface TwitterStore : NSObject
//! Singleton (shared instance)
+ (TwitterStore *)shared;
//! Logs in user with Twitter account
- (void)loginWithCompletion:(void(^)(User *user, NSError *error))completion;
//! Logs out user from Twitter
- (void)logout;
@end


