//
//  Utility.h
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LoginControl;

@interface Utility : NSObject

	/// Corner Rounded Rect
+(void)roundRectCornersForObject:(UIView *)object
				 withBorderWidth:(CGFloat)width
						colorRef:(CGColorRef)colorRef
						  radius:(CGFloat)radius;

	/// Color from Hex Code
+ (UIColor *)colorWithHexString:(NSString *)hexString;

	/// Format Server Date to format passed in request
+(NSString *)formatDateFromString:(NSString *)serverDate withFormat:(NSString *)returnDateFormat;

	/// Two Corner Rect
+ (void)setMaskTo:(id)sender byRoundingCorners:(UIRectCorner)corners withCornerRadii:(CGSize)radii;

	// Get Slider Menu Object for Post login
+(id)getDashboardMenu;

	// Get Login Control Object
+(LoginControl *)getLoginControl;

	// Create Button 
+(UIButton *)createButtonWithFrame:(CGRect)frame
							 title:(NSString *)titleStr image:(NSString *)imageNameStr
				   backgroundColor:(UIColor *)bgColor target:(id)target
						  selector:(SEL)selector;


/*
 Generate session identifier
 Each session will need to have a unique session id generated before connecting.  This may be generated based on timestamps and device UDID.
 */

+(NSString *)generateSessionIdentifier;
@end
