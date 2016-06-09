//
//  TokenStore.h
//  Twilio
//
//  Created by Shafi on 21/01/16.
//  Copyright © 2016 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Store for all Toekn generation-related stuff
 @note: do not use this object directly - use TokenStore instead
 */


@interface TokenStore : NSObject
	//! Singleton (shared instance)
+ (TokenStore *)shared;

	// Generating token with client id
-(void)generateTokenForId:(NSString *)idString withCompletion:(void(^)(NSString * accessToken))completion;
@end
