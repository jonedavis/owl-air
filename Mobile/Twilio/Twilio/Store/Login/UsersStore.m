//
//  UsersStore.m
//  Twilio
//
//  Created by Shafi on 16/07/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UsersStore.h"
#import "TwilioHeader.h"
#import "FacebookStore.h"
#import "TwitterStore.h"

@implementation UsersStore

+ (UsersStore *)shared {
    static dispatch_once_t once;
    static UsersStore *shared;
    dispatch_once(&once, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shared];
}

#pragma mark - Get User List
/*
 Get the users list from Firebase
 */
-(void)getUserNamesWithCompletion:(void (^) (NSArray *namesList))completion{
	dispatch_main_after(0.1, ^{
		[SVProgressHUD show];
        NSString *strURL = [NSString stringWithFormat:@"%@/names",kFireBaseEndPoint];
		Firebase *usersFB = [[Firebase alloc] initWithUrl:strURL];
		[usersFB observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
			[SVProgressHUD dismiss];

			if (snapshot.value != [NSNull null]){
				NSDictionary *usersDict = snapshot.value;
				NSMutableArray *usersArray = [@[] mutableCopy];
					// create empty array to store parsed Users objects
				for (NSString *keyStr in usersDict.allKeys) {
					User *user = [User modelObjectWithDictionary:usersDict[keyStr]];
					[usersArray addObject:user];
				}
				completion(usersArray);
			}
		}];
	});
}

#pragma mark login and logout

- (void)loginWithFacebookAccountAndCompletion:(void(^)(BOOL success, NSError *error))completion {
    [[FacebookStore shared] loginWithCompletion:^(User *user, NSError *error){
        if (error) {
            ExecuteNullableBlockSafely(completion, NO, error);
        }
        else {
            [self loginUser:user];
            ExecuteNullableBlockSafely(completion, YES, error);
        }
    }];
}

- (void)loginWithTwitterAccountAndCompletion:(void(^)(BOOL success, NSError *error))completion {
    [[TwitterStore shared] loginWithCompletion:^(User *user, NSError *error){
        if (error) {
            ExecuteNullableBlockSafely(completion, NO, error);
        }
        else {
			dispatch_async(dispatch_get_main_queue(), ^{
					//Your main thread code goes in here
				[Flurry logEvent:@"Twitter-SignIn" withParameters:@{@"Handler":user.loginName}];
			});
            [self loginUser:user];
            ExecuteNullableBlockSafely(completion, YES, error);
        }
    }];
}

- (void)logout {
    [self enableUser:NO];
	[self logoutUserFromWeb];
    [self setUser:nil];
    [[TwitterStore shared] logout];
}

/*It will add user to firebase and update if already exist.*/

- (void)loginUser:(User *)user {
    [self setUser:user];
    
    Firebase *usersRef = [[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/names",kFireBaseEndPoint]];

    [usersRef updateChildValues:@{user.loginName: [user dictionaryRepresentation]}];
    
    [self enableUser:YES];
}

#pragma mark user state change

-(void)enableUser:(BOOL)enable {
    if (self.user && ![self.user.loginName isEqualToString:@""]) {
        // Update user value
        Firebase *usernameFBRef = [[[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/names/%@",kFireBaseEndPoint,self.user.loginName]] childByAppendingPath:@"mobile"];
        [usernameFBRef setValue:@(enable?1:0)];
    }
}


-(void)logoutUserFromWeb {
	if (self.user && ![self.user.loginName isEqualToString:@""]) {
			// Update user web flag
		Firebase *usernameFBRef = [[[Firebase alloc] initWithUrl:[NSString stringWithFormat:@"%@/names/%@",kFireBaseEndPoint,self.user.loginName]] childByAppendingPath:@"web"];
		[usernameFBRef setValue:@(0)];
	}
}
	//! Get User status
-(void)getUserStatusWithCompletion:(void (^) (BOOL isOnline))completion;{
	dispatch_main_after(0.1, ^{
		[SVProgressHUD show];
		NSString *strURL = [NSString stringWithFormat:@"%@/names/%@/mobile",kFireBaseEndPoint,[UsersStore shared].user.loginName];
		Firebase *usersFB = [[Firebase alloc] initWithUrl:strURL];
		[usersFB observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
			[SVProgressHUD dismiss];
			
			if (snapshot.value != [NSNull null]){
				NSString *statusString = (NSString *)snapshot.value;
				BOOL mobileStatus = statusString.boolValue;
				completion(mobileStatus);
			}
		}];
	});
}
	//! Get User status
-(void)getWebStatusForUserWithCompletion:(void (^) (BOOL isOnline))completion;{
	dispatch_main_after(0.1, ^{
		[SVProgressHUD show];
		NSString *strURL = [NSString stringWithFormat:@"%@/names/%@/web",kFireBaseEndPoint,[UsersStore shared].user.loginName];
		Firebase *usersFB = [[Firebase alloc] initWithUrl:strURL];
		[usersFB observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
			[SVProgressHUD dismiss];
			
			if (snapshot.value != [NSNull null]){
				NSString *statusString = (NSString *)snapshot.value;
				BOOL mobileStatus = statusString.boolValue;
				completion(mobileStatus);
			}
		}];
	});
}
@end


