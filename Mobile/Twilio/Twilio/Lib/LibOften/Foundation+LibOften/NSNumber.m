//
//  NSNumber.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSNumber.h"

@implementation NSNumber (LibOften)

#define NO_PREFIX @""
#define KILO_PREFIX @"k"
#define MEGA_PREFIX @"M"
#define GIGA_PREFIX @"G"
#define ZERO_DECIMAL_PLUS_PREFIX_FORMAT @"%.0f%@"
#define ONE_DECIMAL_PLUS_PREFIX_FORMAT @"%.1f%@"
#define ONE_THOUSAND 1000.0

- (NSString *)humanReadableString {
    if (self.doubleValue <= 0)
        return self.stringValue;
    NSInteger base1000exponent = floor(log10(self.doubleValue) / log10(ONE_THOUSAND));
    NSString *postfix = @[NO_PREFIX, KILO_PREFIX, MEGA_PREFIX, GIGA_PREFIX][base1000exponent];
    double mantissa = self.doubleValue / pow(ONE_THOUSAND, base1000exponent);
    BOOL exponentBase1000isZero = (base1000exponent == 0);
    BOOL moreThanTwoDigitsInMantissa = (mantissa >= 10.0);
    NSString *format = (exponentBase1000isZero || moreThanTwoDigitsInMantissa) ? ZERO_DECIMAL_PLUS_PREFIX_FORMAT : ONE_DECIMAL_PLUS_PREFIX_FORMAT;
    return [NSString stringWithFormat:format, mantissa, postfix];
}

@end


