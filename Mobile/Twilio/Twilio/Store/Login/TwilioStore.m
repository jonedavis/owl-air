//
//  TwilioStore.m
//  Twilio
//
//  Created by Pankaj on 23/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

#import "TwilioStore.h"
#import "LibOften.h"
#import <TwilioConversationsClient/TwilioConversationsClient.h>

@interface TwilioStore ()

@end

@implementation TwilioStore

+ (TwilioStore *)shared {
    AssertMainThreadOnly;
    static dispatch_once_t predicate;
    static TwilioStore *shared;
    dispatch_once(&predicate, ^{
        shared = [[super allocWithZone:nil] init];
    }); return shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self shared];
}


@end


