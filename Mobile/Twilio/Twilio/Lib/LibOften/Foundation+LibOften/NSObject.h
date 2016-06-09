//
//  NSObject.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSObject (LibOften)

@property (readonly) NSString *classNameAsString;

//! Return singleton reprenting absence of object
+ (instancetype)nullObject;

//! Throws an exception if class of object is not equal to class of the receiver
+ (void)assertSameKindOfClass:(id)object;

//! Throws an exception if class of object is not equal to class of the receiver (excluding case object == nil)
+ (void)assertSameKindOfClassOrNil:(id)object;

//! Throws an exception if class of object is not equal to class of the receiver (excluding case object == nil) and returns intact object
+ (instancetype)typecastWithAssertion:(id)object;

//! Throws an exception if object does not conforms to protocol
- (void)assertConformsToProtocol:(Protocol *)protocol;

//! Recursively removes all NSNull objects from the receiver (usually, result of NSJSONSerialization)
- (id)removeNsNullsRecursively;

//! Returns short description like "<CustomObject 0x112233>"
- (NSString *)shortDescription;

@end


