//
//  NSArray.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSArray (LibOften)

//! Returns array with reversed order of elements
- (NSArray *)reversedArray;

//! Returns random element of array
- (id)randomElement;

- (NSAttributedString *)attributedComponentsJoinedByAttributedString:(NSAttributedString *)separator;

//! Returns new array with selected objects from the receiver on which block returned YES
- (NSArray *)filteredArrayUsingBlock:(BOOL(^)(id object))block;

//! Returns new array with objects returned by block which invoked with receiver element as argument
- (NSArray *)arrayByMappingObjectsWithBlock:(id(^)(id object))block;

@end


