//
//  NSArray.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSArray.h"
#import "NSObject.h"
#import "../Misc+LibOften/Macro.h"

@implementation NSArray (LibOften)

- (NSArray *)reversedArray {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[self count]];
    NSEnumerator *enumerator = [self reverseObjectEnumerator];
    for (id element in enumerator)
        [array addObject:element];
    return array;
}

- (id)randomElement {
    return self[arc4random_uniform((u_int32_t)self.count)];
}

- (NSAttributedString *)attributedComponentsJoinedByAttributedString:(NSAttributedString *)separator {
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:@""];
    for (NSUInteger i = 0; i < self.count; i++) {
        NSAttributedString *string = [NSAttributedString typecastWithAssertion:self[i]];
        [result appendAttributedString:string];
        BOOL lastString = (i == self.count-1);
        if (separator && !lastString)
            [result appendAttributedString:separator];
    } return [result copy];
}

- (NSArray *)filteredArrayUsingBlock:(BOOL(^)(id))block {
    AssertBlockNonNullable(block);
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:self.count];
    for (id object in self)
        if (block(object))
            [result addObject:object];
    return [result copy];
}

- (NSArray *)arrayByMappingObjectsWithBlock:(id(^)(id))block {
    AssertBlockNonNullable(block);
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:self.count];
    for (id object in self) {
        id newObject = block(object);
        if (newObject)
            [result addObject:newObject];
    }
    return [result copy];
}

@end


