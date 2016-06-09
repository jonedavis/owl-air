//
//  NSCalendar.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSCalendar (LibOften)

//! Shortcut for -[NSCalendar components:fromDate:toDate:options]
+ (NSInteger)components:(NSCalendarUnit)unit fromDate:(NSDate *)startingDate toDate:(NSDate *)resultDate;

//! Returns gregorian calendar in iOS7/iOS8 compatible way
+ (instancetype)gregorianCalendar;

@end


