//
//  LoginView.m
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "LoginView.h"
#import "TwilioHeader.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "LibOften.h"
#import "CommandUser.h"

@interface LoginView ()<UITextFieldDelegate>
{
    // for User input UITextfield
	IBOutlet UILabel * _usernameTextBG,* _passwordTextBG;
	
    // Login button
	IBOutlet UIButton * _loginButton;
	
    // Twitter Login button
    IBOutlet UIButton * _twitterLoginButton;
    
    // Switch for enabling auto login
	IBOutlet UISwitch * _keepLoggedInSwitch;
    
    // Switch for enabling auto login
    IBOutlet UISwitch * _sandboxDevShuffleSwitch;
}
//Remove facebook login button
//// Button for facebook login
//@property (strong, nonatomic, readonly) UIButton *facebookLoginButton;

@end

@implementation LoginView
//@synthesize facebookLoginButton = _facebookLoginButton;

#pragma mark - Configure View
-(void)setupView{
	
		// Rounded Rect for Button and Textfield
	[Utility roundRectCornersForObject:_usernameTextBG withBorderWidth:1 colorRef:[UIColor whiteColor].CGColor radius:3];
	[Utility roundRectCornersForObject:_passwordTextBG withBorderWidth:1 colorRef:[UIColor whiteColor].CGColor radius:3];
	[Utility roundRectCornersForObject:_loginButton withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:3];
	
    // Auto Set saved selection for Kepp me Logged In
	NSUserDefaults *userdefaults = [NSUserDefaults standardUserDefaults];
	BOOL isAutoLogggedIn = [userdefaults boolForKey:kAUTOLOGGEDIN];
	[_keepLoggedInSwitch setOn:isAutoLogggedIn];
    
    // Check firebase api selected
    BOOL isSandboxOn = [kFireBaseEndPoint isEqualToString:kFireBaseSandbox];
    [_sandboxDevShuffleSwitch setOn:isSandboxOn];
    
    [_twitterLoginButton setActionBlock:^{
        [CommandLoginUserWithTwitter execute];
    }];
    
//    [self addSubview:self.facebookLoginButton];
//    
//    self.facebookLoginButton.actionBlock = ^{
//        [CommandLoginUserWithFacebook execute];
//    };
}

//#pragma mark - Getter Methods
//
//-(UIButton *)facebookLoginButton {
//    if (!_facebookLoginButton) {
//        _facebookLoginButton = [UIButton new];
//        _facebookLoginButton.image = [UIImage imageNamed:@"icon-facebook"];
//        [_facebookLoginButton setTitle:@"  Sign In with Facebook" forState:UIControlStateNormal];
//        [_facebookLoginButton setBackgroundColor:[UIColor colorWithRed:0.2627 green:0.3765 blue:0.6118 alpha:1.0f]];
//        [_facebookLoginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [_facebookLoginButton.titleLabel setFont:[UIFont fontWithName:HELVETICA_NEUE size:17]];
//    } return _facebookLoginButton;
//}

#pragma mark - Switch Button Action

- (IBAction)toggleSandboxDevelopment:(UISwitch *)sender{
    [[NSUserDefaults standardUserDefaults] setObject:sender.isOn ? kFireBaseSandbox : kFireBaseDev forKey:kFirebaseKey];
    NSLog(@"%@",kFireBaseEndPoint);
}

-(IBAction)keepLoggedIn:(UISwitch *)sender{
    [[NSUserDefaults standardUserDefaults] setBool:sender.isOn forKey:kAUTOLOGGEDIN];
}

#pragma mark - Login Button Action

-(IBAction)loginAction:(id)sender{
    // Validate Input field and empty text
    // If Validation success perform login and go to dashboard screen
    if ([self.delegate respondsToSelector:@selector(showPickerView)]) {
        [self.delegate loginAction];
    }
}

#pragma mark - UITextfield Delegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
	[textField resignFirstResponder];
	return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//	if (textField.tag == 0) {
		if ([self.delegate respondsToSelector:@selector(showPickerView)]) {
			[self.delegate showPickerView];
		}
		return false;
//	}
//	return true;
}

#pragma mark - Autolayout

- (void)updateConstraints {
    [super updateConstraints];
//    NSDictionary *subviews = @{@"facebookLogin":self.facebookLoginButton};
//    [self addVisualConstraints:@[@"H:|-(<=20)-[facebookLogin]-(<=20)-|", @"V:[facebookLogin(40)]|"] forSubviews:subviews];
//    [self addConstraintSameCenterXFor:self and:self.facebookLoginButton];
}

@end
