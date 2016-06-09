//
//  Foundation+Custom.m
//  Twilio
//
//  Created by Shafi on 21/06/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Foundation+Custom.h"

@implementation NSDate (Custom)

+ (instancetype)now {return [NSDate date];}

+ (instancetype)todayWithTime:(NSString *)timeString {
	NSAssert(timeString.length > 0, nil);
	NSArray *substrings = [timeString componentsSeparatedByString:@":"]; NSAssert(substrings.count == 2, nil);
	NSInteger hour = [substrings[0] integerValue]; NSAssert(hour >= 0 && hour <= 23, nil);
	NSInteger minute = [substrings[1] integerValue]; NSAssert(minute >= 0 && minute <= 59, nil);
	NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
	NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:[NSDate date]];
	components.hour = hour; components.minute = minute; components.second = 0;
	NSDate *result = [calendar dateFromComponents:components];
	return result;
}

+ (NSDate *)plusTwoDays:(NSDate *)fromDate{
	int daysToAdd = 2;
	return [fromDate dateByAddingTimeInterval:60*60*24*daysToAdd];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
	if (!string || ![string isKindOfClass:[NSString class]]) return nil;
	static NSLocale *enUS; if (!enUS) enUS = [NSLocale localeWithLocaleIdentifier:@"en_US"];
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.locale = enUS;
	formatter.dateFormat = format;
	return [formatter dateFromString:string];
}

- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *formatter = [NSDateFormatter new];
	formatter.dateFormat = format;
	return [formatter stringFromDate:self];
}

@end
