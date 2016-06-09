//
//  NSError.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSError (LibOften)

//! Shortcut for +[NSError errorWithDomain:code:userInfo:] with [NSString stringWithFormat:...] style description
+ (NSError *)errorWithFormat:(NSString *)format, ...;

@end


