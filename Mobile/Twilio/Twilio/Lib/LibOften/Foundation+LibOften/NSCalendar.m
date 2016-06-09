//
//  NSCalendar.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSCalendar.h"
#import "NSDateComponents.h"

@implementation NSCalendar (LibOften)

+ (NSInteger)components:(NSCalendarUnit)unit fromDate:(NSDate *)startingDate toDate:(NSDate *)resultDate {
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:unit fromDate:startingDate toDate:resultDate options:0];
    NSInteger result = [components componentForUnit:unit];
    return result;
}

+ (instancetype)gregorianCalendar {
    return [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

@end



