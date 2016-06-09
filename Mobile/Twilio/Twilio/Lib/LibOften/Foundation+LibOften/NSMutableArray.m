//
//  NSMutableArray.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSMutableArray.h"

@implementation NSMutableArray (LibOften)

- (void)addObjectIfNotNil:(id)anObject {
    if (anObject != nil)
        [self addObject:anObject];
}

@end


