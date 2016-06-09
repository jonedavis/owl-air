//
//  NSBundle.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSBundle.h"

@implementation NSBundle (LibOften)

+ (NSString *)appDisplayName {
    return [[NSBundle mainBundle] infoDictionary][(NSString *)kCFBundleNameKey];
}

+ (NSString *)bundleId {
    return [[NSBundle mainBundle] bundleIdentifier];
}

+ (NSString *)bundleVersion {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
}

+ (NSString *)bundleBuild {
    return [[NSBundle mainBundle] infoDictionary][@"CFBundleVersion"];
}

@end


