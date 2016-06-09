//
//  NSDateComponents.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSDateComponents.h"

@implementation NSDateComponents (LibOften)

+ (instancetype)componentsWithAmount:(NSUInteger)amount ofUnit:(NSCalendarUnit)unit {
    NSDateComponents *components = [NSDateComponents new];
    if (unit == NSCalendarUnitSecond) {
        components.second = amount;
    } else if (unit == NSCalendarUnitMinute) {
        components.minute = amount;
    } else if (unit == NSCalendarUnitHour) {
        components.hour = amount;
    } else if (unit == NSCalendarUnitDay) {
        components.day = amount;
    } else if (unit == NSCalendarUnitMonth) {
        components.month = amount;
    } else if (unit == NSCalendarUnitYear) {
        components.year = amount;
    } else {
        NSAssert(NO, @"Unsupported unit %lu for %s", (unsigned long)unit, __PRETTY_FUNCTION__);
    }
    return components;
}

- (NSInteger)componentForUnit:(NSCalendarUnit)unit {
    if (unit == NSCalendarUnitYear) {
        return self.year;
    } else if (unit == NSCalendarUnitMonth) {
        return self.month;
    } else if (unit == NSCalendarUnitDay) {
        return self.day;
    } else if (unit == NSCalendarUnitHour) {
        return self.hour;
    } else if (unit == NSCalendarUnitMinute) {
        return self.minute;
    } else if (unit == NSCalendarUnitSecond) {
        return self.second;
    } else {
        NSAssert(NO, @"Unknown unit %lu for %s", (unsigned long)unit, __PRETTY_FUNCTION__);
        return NSIntegerMax;
    }
}

@end


