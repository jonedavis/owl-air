//
//  CommandUser.m
//  Twilio
//
//  Created by Pankaj on 21/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

#import "CommandUser.h"
#import "User.h"
#import "UsersStore.h"
#import "TwilioHeader.h"

@implementation Command

#pragma mark actions

+ (void)execute {
    [[self new] execute];
}

- (void)execute {}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation CommandLoginUserWithFacebook

- (void)execute {
    [super execute];
    [SVProgressHUD show];
    [[UsersStore shared] loginWithFacebookAccountAndCompletion:^(BOOL success, NSError *error){
        [SVProgressHUD dismiss];
        if (error) {
            [UIAlertView showWithTitle:@"Error" message:error.localizedDescription buttons:@[@"Ok"] completion:NULL];
        } else {
            [[UIApplication visibleNavigationController] pushViewController:[Utility getDashboardMenu] animated:YES];
        }
    }];
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation CommandLoginUserWithTwitter

- (void)execute {
    [super execute];
    [[UsersStore shared] loginWithTwitterAccountAndCompletion:^(BOOL success, NSError *error){
        if (error) {
            [UIAlertView showWithTitle:@"Error" message:error.localizedDescription buttons:@[@"Ok"] completion:NULL];
        } else {
            [[UIApplication visibleNavigationController] pushViewController:[Utility getDashboardMenu] animated:YES];
        }
    }];
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation CommandLoginUser

+ (Command *)commandWithUser:(User *)user {
    Command *command = [self new];
    command.user = user;
    return command;
}

- (void)execute {
    [super execute];
    if (self.user && ![self.user.loginName isEqualToString:@""]) {
        [[UsersStore shared] setUser:self.user];
        [[UsersStore shared] enableUser:YES];
		[[UIApplication visibleNavigationController] pushViewController:[Utility getDashboardMenu] animated:YES];
    }
    else{
        [UIAlertView showWithTitle:@"" message:@"Please make sure you have selected a user." buttons:@[@"Ok"] completion:NULL];
    }
}

@end

////////////////////////////////////////////////////////////////////////////////

@implementation CommandLogoutUser

- (void)execute {
    [super execute];
    // Logout and navigate to Login Screen
    [[UsersStore shared] logout];
    [[UIApplication appWindow] setRootViewController:[[UIStoryboard mainStoryboard] instantiateViewControllerWithIdentifier:kLoginControl]];
}

@end


