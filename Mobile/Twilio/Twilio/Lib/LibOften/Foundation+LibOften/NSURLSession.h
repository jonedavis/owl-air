//
//  NSURLSession.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSURLSession (LibOften)

//! Asynchronously returns NSData from URL with a completion block
+ (void)dataFromURL:(NSURL *)url completion:(void(^)(NSData *data))completion;

// Asynchronously returns serialized JSON object from URL with a completion block
+ (void)jsonFromURL:(NSURL *)url completion:(void(^)(id json))completion;

@end


