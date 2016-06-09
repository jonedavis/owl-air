//
//  NSUserDefaults.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSUserDefaults.h"

@implementation NSUserDefaults (LibOften)

+ (void)dump {
    NSString *bundleId = [[NSBundle mainBundle] bundleIdentifier];
    NSDictionary *dump = [[NSUserDefaults standardUserDefaults] persistentDomainForName:bundleId];
    NSLog(@"Dump of %@:\n%@", NSStringFromClass(self.class), dump);
}

@end


