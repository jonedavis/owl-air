//
//  TokenStore.m
//  Twilio
//
//  Created by Shafi on 21/01/16.
//  Copyright © 2016 Impekable. All rights reserved.
//

#import "TokenStore.h"
#import "LibOften.h"
#import "Constant.h"

@interface TokenStore ()

@end

@implementation TokenStore

+ (TokenStore *)shared {
	AssertMainThreadOnly;
	static dispatch_once_t predicate;
	static TokenStore *shared;
	dispatch_once(&predicate, ^{
		shared = [[super allocWithZone:nil] init];
	}); return shared;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
	return [self shared];
}

-(void)generateTokenForId:(NSString *)idString withCompletion:(void(^)(NSString * accessToken))completion{
	NSString *urlString = [kTokenGenerateURL getURLWithParameter:@{kTokenUserId: idString}];
	NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];

	NSString *authValue = [NSString stringWithFormat: @"Basic %@",[[@"iosapp:abc123" dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:0]];
	[request setValue:authValue forHTTPHeaderField:@"Authorization"];
	
		//create the task
	[[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
		NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
		completion(responseString);
	}] resume];
}

@end
