//
//  Foundation+Custom.h
//  Twilio
//
//  Created by Shafi on 21/06/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSDate (Custom)
	//! Shortcut for [NSDate date]
+ (instancetype)now;
	//! Returns NSDate object for time given in 24h format HH:MM and today
+ (instancetype)todayWithTime:(NSString *)timeString;
	//! Returns NSDate object plus two day from day which is passed as parameter
+ (NSDate *)plusTwoDays:(NSDate *)fromDate;
	//! Returns NSDate object for date in string with given format
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;
	//! Returns string from date with given format (NSDateFormatter)
- (NSString *)stringWithFormat:(NSString *)format;
@end
