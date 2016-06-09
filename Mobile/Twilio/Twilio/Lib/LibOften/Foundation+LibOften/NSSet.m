//
//  NSSet.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSSet.h"

@implementation NSSet (LibOften)

+ (instancetype)intersectionOfSet:(NSSet *)aSet withSet:(NSSet *)anotherSet {
    if (!aSet || !anotherSet)
        return nil;
    NSMutableSet *mutableSet = [aSet mutableCopy];
    [mutableSet intersectSet:anotherSet];
    return [mutableSet copy];
}

@end


