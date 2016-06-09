//
//  NSDate.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSDate.h"
#import "NSDateComponents.h"

@implementation NSDate (LibOften)

+ (NSDate *)now {
    return [NSDate date];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format {
    return [NSDate dateFromString:string withFormat:format timeZone:[NSTimeZone localTimeZone]];
}

+ (NSDate *)dateFromString:(NSString *)string withFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone {
    if (!string || ![string isKindOfClass:[NSString class]])
        return nil;
    static NSLocale *enUS;
    if (!enUS)
        enUS = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.locale = enUS;
    formatter.timeZone = timeZone;
    formatter.dateFormat = format;
    return [formatter dateFromString:string];
}

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.dateFormat = format;
    return [formatter stringFromDate:self];
}

- (BOOL)isSameDay:(NSDate *)date {
    NSDateComponents *c1 = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSDateComponents *c2 = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:date];
    return c1.era == c2.era && c1.year == c2.year && c1.month == c2.month && c1.day == c2.day;
}

- (NSString *)humanReadablePeriodFromNow {
    static NSCalendarUnit units = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    static NSCalendar *calendar;
    if (!calendar)
        calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *cm = [calendar components:units fromDate:self toDate:[NSDate date] options:0];
    if (cm.year != 0) {
        return [NSString stringWithFormat:labs(cm.year) == 1 ? @"%liyear" : @"%liyears", labs(cm.year)];
    } else if (cm.month != 0) {
        return [NSString stringWithFormat:labs(cm.month) == 1 ? @"%limonth" : @"%limonths", labs(cm.month)];
    } else if (cm.day != 0) {
        return [NSString stringWithFormat:labs(cm.day) == 1 ? @"%liday" : @"%lidays", labs(cm.day)];
    } else if (cm.hour != 0) {
        return [NSString stringWithFormat:labs(cm.hour) == 1 ? @"%lihr" : @"%lihrs", labs(cm.hour)];
    } else if (cm.minute != 0) {
        return [NSString stringWithFormat:labs(cm.minute) == 1 ? @"%limin" : @"%limins", labs(cm.minute)];
    } else if (cm.second != 0) {
        return [NSString stringWithFormat:labs(cm.second) == 1 ? @"%lisec" : @"%lisecs", labs(cm.second)];
    } else {
        return @"just now";
    }
}

- (BOOL)isInPast {
    return [self timeIntervalSinceNow] < 0.0;
}

+ (instancetype)dateByAdding:(NSInteger)amount unitsToNow:(NSCalendarUnit)unit {
    NSDateComponents *components = [NSDateComponents componentsWithAmount:amount ofUnit:unit];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDate *result = [calendar dateByAddingComponents:components toDate:[NSDate now] options:0];
    return result;
}

+ (instancetype)dateBySubtructing:(NSInteger)amount unitsFromNow:(NSCalendarUnit)unit {
    return [self dateByAdding:-amount unitsToNow:unit];
}

- (BOOL)dateIsLaterThan:(NSInteger)amount unitsAfterNow:(NSCalendarUnit)unit {
    NSDate *threshold = [NSDate dateByAdding:amount unitsToNow:unit];
    return self.timeIntervalSinceReferenceDate > threshold.timeIntervalSinceReferenceDate;
}

- (BOOL)dateIsLaterThan:(NSInteger)amount unitsBeforeNow:(NSCalendarUnit)unit {
    NSDate *threshold = [NSDate dateBySubtructing:amount unitsFromNow:unit];
    return self.timeIntervalSinceReferenceDate > threshold.timeIntervalSinceReferenceDate;
}

- (BOOL)dateIsEarlierThan:(NSInteger)amount unitsAfterNow:(NSCalendarUnit)unit {
    NSDate *threshold = [NSDate dateByAdding:amount unitsToNow:unit];
    return self.timeIntervalSinceReferenceDate < threshold.timeIntervalSinceReferenceDate;
}

- (BOOL)dateIsEarlierThan:(NSInteger)amount unitsBeforeNow:(NSCalendarUnit)unit {
    NSDate *threshold = [NSDate dateBySubtructing:amount unitsFromNow:unit];
    return self.timeIntervalSinceReferenceDate < threshold.timeIntervalSinceReferenceDate;
}

- (NSTimeInterval)timeIntervalBeforeNow {
    return - [self timeIntervalSinceNow];
}

- (NSDate *)addDays:(NSInteger)days {
    return [self dateByAddingTimeInterval:60*60*24*days];
}

@end


