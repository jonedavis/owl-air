//
//  NSDateComponents.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSDateComponents (LibOften)

+ (instancetype)componentsWithAmount:(NSUInteger)amount ofUnit:(NSCalendarUnit)unit;

//! Returns date component from NSCalendarUnit
- (NSInteger)componentForUnit:(NSCalendarUnit)unit;

@end


