//
//  UIView+Controller.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIView+Controller.h"

@implementation UIView (Controller)

- (UIViewController *)viewController {
	for (UIResponder * nextResponder = self.nextResponder; nextResponder; nextResponder = nextResponder.nextResponder){
		if ([nextResponder isKindOfClass:[UIViewController class]])
			return (UIViewController *)nextResponder;
	}
		// Not found
	NSLog(@"%@ doesn't seem to have a viewController", self);
	return nil;
}

@end
