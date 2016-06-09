//
//  NSIndexPath.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSIndexPath (LibOften)

//! Returns array of index paths in range
+ (NSArray *)indexPathsForItemsInRange:(NSRange)range inSection:(NSInteger)section;

@end


