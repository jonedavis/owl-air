//
//  TwitterStore.m
//  Twilio
//
//  Created by Pankaj on 23/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

#import "TwitterStore.h"
#import "User.h"
#import <Fabric/Fabric.h>
#import "LibOften.h"
#import <TwitterKit/TwitterKit.h>
#import "SVProgressHUD.h"

@interface TwitterStore ()
/// Current app user
@property (readonly) User *currentUser;
@end

@implementation TwitterStore

+ (TwitterStore *)shared {
    AssertMainThreadOnly;
    static dispatch_once_t predicate;
    static TwitterStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shared];
}

- (instancetype)init {
    if (self = [super init]) {
        // We init TwitterKit in AppStateStore because only the first call to +[Fabric with:] is honored (and we need CrashlyticsKit too)
        NSString *twitterConsumerKey; NSString *twitterConsumerSecret;
        [self getFromInfoPlistTwitterConsumerKey:&twitterConsumerKey andTwitterConsumerSecret:&twitterConsumerSecret];
        [[Twitter sharedInstance] startWithConsumerKey:twitterConsumerKey consumerSecret:twitterConsumerSecret];
        [Fabric with:@[[Twitter sharedInstance]]];
    } return self;
}

- (void)getFromInfoPlistTwitterConsumerKey:(NSString **)twitterConsumerKey andTwitterConsumerSecret:(NSString **)twitterConsumerSecret {
    AssertObjectNonNullable(twitterConsumerKey);
    AssertObjectNonNullable(twitterConsumerSecret);
    NSDictionary *fabricConfig = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"Fabric"];
    for (NSDictionary *kitConfig in (NSArray *)fabricConfig[@"Kits"])
        if ([kitConfig[@"KitName"] isEqualToString:@"Twitter"]) {
            *twitterConsumerKey = kitConfig[@"KitInfo"][@"consumerKey"];
            *twitterConsumerSecret = kitConfig[@"KitInfo"][@"consumerSecret"];
            return;
        }
    NSAssert(NO, @"Twitter configuration is not found in main bundle");
}

#pragma mark login

- (void)loginWithCompletion:(void(^)(User *user, NSError *error))completion {
    AssertBlockNonNullable(completion);
    [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            [SVProgressHUD show];
			TWTRAPIClient *client = [[TWTRAPIClient alloc] initWithUserID:session.userID];
            [client loadUserWithID:session.userID completion:^(TWTRUser *twitterUser, NSError *error){
                [SVProgressHUD dismiss];
                if (error) {
                    NSLog(@"error: %@", [error localizedDescription]);
                    completion(nil, error);
                } else {
                    User *user = [User new];
                    user.loginName = twitterUser.screenName;
                    user.name = twitterUser.name;
                    user.profileimage = twitterUser.profileImageLargeURL;
                    user.timestamp = [[NSDate date] timeIntervalSince1970];
                    user.mobile = 1;
                    completion(user, nil);
                }
            }];
        } else {
            NSLog(@"error: %@", [error localizedDescription]);
            completion(nil, error);
        }
    }];
}

- (void)logout {
    // Objective-C
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID;
    if (userID) {//Check if logged in.
        [store logOutUserID:userID];
    }
}

@end


