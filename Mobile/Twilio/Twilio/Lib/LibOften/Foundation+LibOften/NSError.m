//
//  NSError.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSError.h"
#import "NSBundle.h"

@implementation NSError (LibOften)

+ (NSError *)errorWithFormat:(NSString *)format, ... {
    va_list arguments;
    va_start(arguments, format);
    NSString *description = [[NSString alloc] initWithFormat:format arguments:arguments];
    NSString *domain = [[NSBundle mainBundle] bundleIdentifier];
    NSInteger code = -1;
    NSDictionary *userInfo = @{NSLocalizedDescriptionKey:description, @"version":[NSBundle bundleVersion], @"build":[NSBundle bundleBuild]};
    NSError *error = [self errorWithDomain:domain code:code userInfo:userInfo];
    va_end(arguments);
    return error;
}

@end


