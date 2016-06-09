//
//  User.m
//
//  Created by Shaffiulla Khan on 22/07/15
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "User.h"

#define MOBILE_KEY          @"mobile"
#define LOGIN_NAME_KEY      @"login"
#define NAME_KEY            @"name"
#define PROFILE_IMAGE_KEY   @"profileimage"
#define TIMESTAMP_KEY       @"timestamp"

@interface User ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation User

@synthesize mobile = _mobile;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
        self.mobile = [dict[MOBILE_KEY] doubleValue];
        self.name = dict[NAME_KEY];
        self.loginName = dict[LOGIN_NAME_KEY];
        self.profileimage = dict[PROFILE_IMAGE_KEY];
        self.timestamp = [dict[TIMESTAMP_KEY] integerValue];
    }
    return self;
}

- (NSDictionary *)dictionaryRepresentation {
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[NSNumber numberWithDouble:self.mobile] forKey:MOBILE_KEY];
    [mutableDict setValue:self.name forKey:NAME_KEY];
    [mutableDict setValue:self.loginName forKey:LOGIN_NAME_KEY];
    [mutableDict setValue:self.profileimage forKey:PROFILE_IMAGE_KEY];
    [mutableDict setValue:[NSNumber numberWithInteger:self.timestamp] forKey:TIMESTAMP_KEY];
    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}

@end


