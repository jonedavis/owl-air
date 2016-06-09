//
//  FacebookStore.m
//  Twilio
//
//  Created by Pankaj on 21/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

#import "FacebookStore.h"
#import "User.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

#define PERMISSION_READ_EMAIL @"email"
#define PERMISSION_READ_ABOUT_ME @"user_about_me"
#define PERMISSION_READ_PUBLIC_PROFILE @"public_profile"
#define PERMISSION_PUBLISH_ACTIONS @"publish_actions"
#define HTTP_METHOD_GET @"GET"
#define HTTP_METHOD_POST @"POST"
#define GRAPH_PATH_ME @"me"

@interface FacebookStore ()
/// Current app user
@property (readonly) User *currentUser;
@end

@implementation FacebookStore

+ (FacebookStore *)shared {
    static dispatch_once_t predicate;
    static FacebookStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shared];
}

#pragma mark app status change handling

- (void)handleApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application didFinishLaunchingWithOptions:launchOptions];
}

- (void)handleApplicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)handleOpenURL:(NSURL *)url withSourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:[UIApplication sharedApplication] openURL:url sourceApplication:sourceApplication annotation:annotation];
}

#pragma mark user management

- (BOOL)isPublishActionsPermissionsGranted {
    return [[FBSDKAccessToken currentAccessToken] hasGranted:PERMISSION_PUBLISH_ACTIONS];
}

#pragma mark user login

- (void)loginWithCompletion:(void(^)(User *user, NSError *error))completion {
    // Login with read permission
    NSArray *readPermissions = @[PERMISSION_READ_EMAIL, PERMISSION_READ_ABOUT_ME, PERMISSION_READ_PUBLIC_PROFILE];

    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:readPermissions handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error || result.isCancelled) {
              completion(nil, error);
         } else {
             [self updateCurrentUserFromFacebookWithCompletion:^(User *user, NSError *error){
                 completion(user, error);
             }];
         }
     }];
}

- (void)updateCurrentUserFromFacebookWithCompletion:(void(^)(User *user, NSError *error))completion {
    NSDictionary *params = @{@"fields":@"email,first_name,last_name,picture.width(320).height(320)"};
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:GRAPH_PATH_ME parameters:params];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error){
        if (error) {
            completion(nil, error);
        } else {
            User *user = [User new];
            user.name = result[@"first_name"];
            user.loginName = result[@"email"];
            user.profileimage = result[@"picture"][@"data"][@"url"];
            user.timestamp = [[NSDate date] timeIntervalSince1970];
            user.mobile = 1;
            completion(user, nil);
        }
    }];
}

@end


