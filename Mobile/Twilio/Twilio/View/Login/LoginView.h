//
//  LoginView.h
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginDelegate <NSObject>

-(void)showPickerView;
-(void)loginAction;

@end
@interface LoginView : UIView
@property (nonatomic, assign) IBOutlet UITextField * _usernameTf;
@property (nonatomic, assign) id <LoginDelegate> delegate;
	/// Customise View Visuals/ Rounded Button/View/Textfield
-(void)setupView;
@end
