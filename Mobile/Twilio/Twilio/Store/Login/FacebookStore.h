//
//  FacebookStore.h
//  Twilio
//
//  Created by Pankaj on 21/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

@import Foundation;
@import UIKit;
@class User;
/**
 Store for all Facebook-related stuff
 @note do not use this object directly - use UserStore instead
 */

@interface FacebookStore : NSObject
//! Shared instance
+ (FacebookStore *)shared;
//! Starts Facebook operations
- (void)handleApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;
//! Resumes Facebook operations
- (void)handleApplicationDidBecomeActive:(UIApplication *)application;
//! Handles open URL for SSO and interaction with Facebook app
- (BOOL)handleOpenURL:(NSURL *)url withSourceApplication:(NSString *)sourceApplication annotation:(id)annotation;
//! Logs in user with Facebook account
- (void)loginWithCompletion:(void(^)(User *user, NSError *error))completion;
@end


