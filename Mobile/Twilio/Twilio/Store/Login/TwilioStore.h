//
//  TwilioStore.h
//  Twilio
//
//  Created by Pankaj on 23/09/15.
//  Copyright (c) 2016 Impekable. All rights reserved.
//

@import Foundation;

/**
 Store for all TwilioStore-related stuff
 @note: do not use this object directly - use UserStore instead
 */

@interface TwilioStore : NSObject
//! Singleton (shared instance)
+ (TwilioStore *)shared;
@end


