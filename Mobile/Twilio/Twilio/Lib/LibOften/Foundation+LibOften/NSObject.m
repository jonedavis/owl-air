//
//  NSObject.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSObject.h"
#import <objc/runtime.h>

@implementation NSObject (LibOften)

static char null_object_key;

+ (instancetype)nullObject {
    if (![self associatedNullObject])
        objc_setAssociatedObject(self, &null_object_key, [self new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return [self associatedNullObject];
}

+ (instancetype)associatedNullObject {
    return objc_getAssociatedObject(self, &null_object_key);
}

+ (void)assertSameKindOfClass:(id)object {
    NSAssert([object isKindOfClass:self.class], @"Object %@ is not kind of class %@", object, NSStringFromClass(self.class));
}

+ (void)assertSameKindOfClassOrNil:(id)object {
    if (object)
        [self assertSameKindOfClass:object];
}

+ (instancetype)typecastWithAssertion:(id)object {
    [self assertSameKindOfClassOrNil:object];
    return object;
}

- (void)assertConformsToProtocol:(Protocol *)protocol {
    NSAssert([self conformsToProtocol:protocol], @"Object %@ does not conforms to protocol %@", self, NSStringFromProtocol(protocol));
}

- (id)removeNsNullsRecursively {
    static NSNull *null;
    if (!null)
        null = [NSNull null];
    if ([self isKindOfClass:[NSString class]] || [self isKindOfClass:[NSNumber class]]) {
        return self;
    } else if ([self isKindOfClass:[NSArray class]]) {
        NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:[(NSArray *)self count]];
        for (id object in (NSArray *)self) {
            id clean = [object removeNsNullsRecursively];
            if (clean)
                [result addObject:clean];
        }
        return result.count > 0 ? result : nil;
    } else if ([self isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *result = [[NSMutableDictionary alloc] initWithCapacity:[(NSDictionary *)self count]];
        for (id key in [(NSDictionary *)self allKeys]) {
            id clean = [[(NSDictionary *)self objectForKey:key] removeNsNullsRecursively];
            if (clean)
                [result setObject:clean forKey:key];
        }
        return result.count > 0 ? result : nil;
    } else {
        return nil;
    }
}

- (NSString *)shortDescription {
    return [NSString stringWithFormat:@"<%@: %p>", NSStringFromClass(self.class), self];
}

- (NSString *)classNameAsString {
    return NSStringFromClass(self.class);
}

@end


