//
//  NSIndexPath.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSIndexPath.h"
@import UIKit;

@implementation NSIndexPath (LibOften)

+ (NSArray *)indexPathsForItemsInRange:(NSRange)range inSection:(NSInteger)section {
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:range.length];
    for (NSInteger itemIndex = range.location; itemIndex < range.location + range.length; itemIndex++)
        [result addObject:[NSIndexPath indexPathForItem:itemIndex inSection:section]];
    return result;
}

@end


