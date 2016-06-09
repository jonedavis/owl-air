//
//  NSURLSession.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSURLSession.h"
#import "GCD.h"
#import "NSObject.h"

@implementation NSURLSession (LibOften)

+ (void)dataFromURL:(NSURL *)url completion:(void(^)(NSData *data))completion {
    //NSLog(@"GET %@", url);
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error){
        completion(data);
    }] resume];
}

+ (void)jsonFromURL:(NSURL *)url completion:(void(^)(id json))completion {
    [NSURLSession dataFromURL:url completion:^(NSData *data){
        id result = data ? [NSJSONSerialization JSONObjectWithData:data options:0 error:nil] : nil; // Parse JSON
        result = [result removeNsNullsRecursively]; // Remove NSNull objects
        completion(result);
    }];
}


@end


