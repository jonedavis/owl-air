//
//  ReachabilityManager.h
//  Twilio
//
//  Created by Shafi on 28/03/16.
//  Copyright © 2016 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Reachability;

@interface ReachabilityManager : NSObject
@property (strong, nonatomic) Reachability *reachability;

#pragma mark -
#pragma mark Shared Manager
+ (ReachabilityManager *)sharedManager;

#pragma mark -
#pragma mark Class Methods
+ (BOOL)isReachable;
+ (BOOL)isUnreachable;
+ (BOOL)isReachableViaWWAN;
+ (BOOL)isReachableViaWiFi;

@end
