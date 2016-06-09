//
//  NSDate.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSDate (LibOften)

//! Shortcut for +[NSDate date]
+ (NSDate *)now;

//! Returns NSDate object for date in string with given format
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format;

//! Returns NSDate object for date in string with given format and time zone
+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone;

//! Returns string from date with given format (NSDateFormatter)
- (NSString *)stringWithFormat:(NSString *)format;

//! Returns YES if date is in past
- (BOOL)isInPast;

//! Returns YES if given date is within the same day with receiver
- (BOOL)isSameDay:(NSDate *)date;

//! Returns human-readable period from now (like "5 days ago")
- (NSString *)humanReadablePeriodFromNow;

+ (instancetype)dateByAdding:(NSInteger)amount unitsToNow:(NSCalendarUnit)unit;

+ (instancetype)dateBySubtructing:(NSInteger)amount unitsFromNow:(NSCalendarUnit)unit;

- (BOOL)dateIsLaterThan:(NSInteger)amount unitsAfterNow:(NSCalendarUnit)unit;

- (BOOL)dateIsLaterThan:(NSInteger)amount unitsBeforeNow:(NSCalendarUnit)unit;

- (BOOL)dateIsEarlierThan:(NSInteger)amount unitsAfterNow:(NSCalendarUnit)unit;

- (BOOL)dateIsEarlierThan:(NSInteger)amount unitsBeforeNow:(NSCalendarUnit)unit;

- (NSTimeInterval)timeIntervalBeforeNow;

//! Add day to date
- (NSDate *)addDays:(NSInteger)days;

@end


