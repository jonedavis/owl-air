//
//  UsersStore.h
//  Twilio
//
//  Created by Shafi on 16/07/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "User.h"

@interface UsersStore : NSObject
//! Shared instance
+ (UsersStore *)shared;
//! Saved User
@property (strong, nonatomic) User *user;
//! Get the users list from Firebase
-(void)getUserNamesWithCompletion:(void (^) (NSArray *namesList))completion;
//! Logs in user with Facebook account
- (void)loginWithFacebookAccountAndCompletion:(void(^)(BOOL success, NSError *error))completion;
//! Logs in user with Twitter account
- (void)loginWithTwitterAccountAndCompletion:(void(^)(BOOL success, NSError *error))completion;
//! Enable/Disable user on application state changes
-(void)enableUser:(BOOL)enable;
-(void)logoutUserFromWeb;
//! Logout current user
- (void)logout;
//! Get User status
-(void)getUserStatusWithCompletion:(void (^) (BOOL isOnline))completion;
	//! Get User Web status
-(void)getWebStatusForUserWithCompletion:(void (^) (BOOL isOnline))completion;
@end


