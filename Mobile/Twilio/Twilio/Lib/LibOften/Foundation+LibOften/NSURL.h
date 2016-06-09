//
//  NSURL.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSURL (LibOften)

//! Returns new URL by appending string to the receiver
- (NSURL *)URLByAppendingString:(NSString *)string;

//! Returns host part without www. prefix
- (NSString *)hostWithoutWww;

@end


