//
//  UIViewController+Customise.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIViewController+Customise.h"
#import "RESideMenu.h"

@implementation UIViewController (Customise)

-(IBAction)sideMenuAction:(id)sender{
	[self presentLeftMenuViewController:self];
}
@end
