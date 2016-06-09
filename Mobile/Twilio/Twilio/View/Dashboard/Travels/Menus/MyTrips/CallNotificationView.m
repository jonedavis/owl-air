//
//  CallNotificationView.m
//  Twilio
//
//  Created by Shafi on 18/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "CallNotificationView.h"

@implementation CallNotificationView

-(id)initWithFrame:(CGRect)frame {
		/// Load view from Xib
	self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
										  owner:self
										options:nil] objectAtIndex:0];
	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.frame = frame;
	return self;
}
@end
