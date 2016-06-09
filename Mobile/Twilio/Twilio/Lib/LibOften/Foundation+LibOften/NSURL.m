//
//  NSURL.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSURL.h"

@implementation NSURL (LibOften)

- (NSURL *)URLByAppendingString:(NSString *)string {
    return [NSURL URLWithString:[[self absoluteString] stringByAppendingString:string]];
}

- (NSString *)hostWithoutWww {
    return [self.host stringByReplacingOccurrencesOfString:@"www." withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 4)];
}

@end


