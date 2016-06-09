//
//  NSMutableArray.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSMutableArray (LibOften)

//! Inserts a given object at the end of the array if it's not nil
- (void)addObjectIfNotNil:(id)anObject;

@end


