//
//  NSNumber.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSNumber (LibOften)

//! Returns string with order qualifier like 12k, 1.2G
- (NSString *)humanReadableString;

@end


