//
//  Utility.m
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Utility.h"
#import "TwilioHeader.h"

@implementation Utility

	/// Corner Rounded Rect
+(void)roundRectCornersForObject:(UIView *)object withBorderWidth:(CGFloat)width colorRef:(CGColorRef)colorRef radius:(CGFloat)radius{
	object.layer.cornerRadius = radius;
	object.layer.borderWidth = width;
	object.layer.borderColor = colorRef;
}


	// Color From Hex Code
+ (UIColor *)colorWithHexString:(NSString *)hexString {
	unsigned rgbValue = 0;
	NSScanner *scanner = [NSScanner scannerWithString:hexString];
	[scanner setScanLocation:0]; // bypass '#' character
	[scanner scanHexInt:&rgbValue];
	
	return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}

	// Formatted Date
+(NSString *)formatDateFromString:(NSString *)serverDate withFormat:(NSString *)returnDateFormat{
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat:@"MM-dd-yyyy"];
	
	NSDate *date = [dateFormat dateFromString:serverDate];
	[dateFormat setDateFormat:returnDateFormat];
	
	return [NSString stringWithFormat:@"%@",[dateFormat stringFromDate:date]];
}

	/// Two Corner Rect
+ (void)setMaskTo:(id)sender byRoundingCorners:(UIRectCorner)corners withCornerRadii:(CGSize)radii
{
		// UIButton requires this
	[sender layer].cornerRadius = 0.0;
	
		//Create shape which we will draw.
	CGRect rectangle = CGRectMake(0,
								  0,
								  [sender bounds].size.width,
								  [sender bounds].size.height);
	UIBezierPath *shapePath = [UIBezierPath bezierPathWithRoundedRect:rectangle
													byRoundingCorners:corners
														  cornerRadii:radii];
	
	CAShapeLayer *newCornerLayer = [CAShapeLayer layer];
//	newCornerLayer.frame = rectangle;
	newCornerLayer.path = shapePath.CGPath;
	[sender layer].mask = newCornerLayer;
}


	// Get Slider Menu Object for Post login
+(id)getDashboardMenu{
	
	UIStoryboard *storyBoard = [UIStoryboard mainStoryboard];
	
		// TabBar Controller Object
	TravelTabControl *tabBarControl = [storyBoard instantiateViewControllerWithIdentifier:kTabBarControl];
	
		// Slider Controller Object
	SliderControl *sliderControl = [storyBoard instantiateViewControllerWithIdentifier:kSliderControl];
	
		// Create side menu controller
		//
	RESideMenu *container = [[RESideMenu alloc] initWithContentViewController:tabBarControl.navigationController
																	leftMenuViewController:sliderControl
																   rightMenuViewController:nil];
	[container setContentViewController:tabBarControl];
	container.backgroundImage = [UIImage imageNamed:@"BackGround"];
	
	return container;
}

	// Get Login Control Object
+(LoginControl *)getLoginControl{
	UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
	
	LoginControl *loginControl = [storyBoard instantiateViewControllerWithIdentifier:kLoginControl];
	
	return loginControl;
}

	// Create button Object
+(UIButton *)createButtonWithFrame:(CGRect)frame title:(NSString *)titleStr image:(NSString *)imageNameStr backgroundColor:(UIColor *)bgColor target:(id)target selector:(SEL)selector{
	UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = frame;
	[button setTitle:titleStr forState:UIControlStateNormal];
	
	if (imageNameStr) {
		[button setImage:[UIImage imageNamed:imageNameStr] forState:UIControlStateNormal];
	}
	
	[button setBackgroundColor:bgColor];
	
	[button addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
	
		// rounded Rect button
	[self roundRectCornersForObject:button withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:3];
	
	return button;
}


/*
 Generate session identifier
 Each session will need to have a unique session id generated before connecting.  This may be generated based on timestamps and device UDID.
 */

+(NSString *)generateSessionIdentifier{
//		// Generate a string with combination of NSUUID & timestamp
//	NSString *sessionIdentifier = [NSString stringWithFormat:@"%@%f",[NSUUID UUID].UUIDString,[[NSDate date] timeIntervalSince1970]];

	
		// Generate a string with timestamp
	NSString *sessionIdentifier = [NSString stringWithFormat:@"%@",@((long)(NSTimeInterval)[[NSDate date] timeIntervalSince1970])];

	return sessionIdentifier;
}

@end
